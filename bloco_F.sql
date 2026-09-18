-- 1. CTE de faturamento mensal por estado e variação percentual mês a mês.
-- Agrupa a receita bruta por estado/mês e utiliza a função LAG() para comparar o faturamento atual com o mês anterior.
WITH faturamento_mensal AS (
    SELECT 
        c.customer_state,
        DATE_TRUNC('month', o.order_purchase_timestamp)::DATE AS mes_ano,
        SUM(oi.price) AS faturamento
    FROM olist_orders_dataset o
    JOIN olist_customers_dataset c ON o.customer_id = c.customer_id
    JOIN olist_order_items_dataset oi ON o.order_id = oi.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY c.customer_state, DATE_TRUNC('month', o.order_purchase_timestamp)
),
faturamento_com_lag AS (
    SELECT 
        customer_state,
        mes_ano,
        faturamento,
        LAG(faturamento) OVER (PARTITION BY customer_state ORDER BY mes_ano) AS faturamento_mes_anterior
    FROM faturamento_mensal
)
SELECT 
    customer_state,
    mes_ano,
    faturamento,
    faturamento_mes_anterior,
    ROUND(
        ((faturamento - faturamento_mes_anterior) / NULLIF(faturamento_mes_anterior, 0)) * 100, 
        2
    ) AS variacao_percentual
FROM faturamento_com_lag
ORDER BY customer_state, mes_ano;

-- 2. CTE com volume e nota média de avaliações por categoria de produto.
-- Mapeia a satisfação do cliente filtrando apenas categorias com volume relevante de avaliações (> 50) para destacar as piores reputações.
WITH metricas_categoria AS (
    SELECT 
        pct.product_category_name_english AS categoria,
        COUNT(r.review_id) AS total_avaliacoes,
        ROUND(AVG(r.review_score), 2) AS nota_media
    FROM olist_order_reviews_dataset r
    JOIN olist_order_items_dataset oi ON r.order_id = oi.order_id
    JOIN olist_products_dataset p ON oi.product_id = p.product_id
    JOIN product_category_name_translation pct ON p.product_category_name = pct.product_category_name
    GROUP BY pct.product_category_name_english
)
SELECT 
    categoria,
    total_avaliacoes,
    nota_media
FROM metricas_categoria
WHERE total_avaliacoes >= 50
ORDER BY nota_media ASC, total_avaliacoes DESC;

-- 3. CTE de frete médio por estado comparado com a média geral do país.
-- Calcula o custo logístico médio por estado e o relaciona com o benchmark global da base.
WITH frete_por_estado AS (
    SELECT 
        c.customer_state,
        ROUND(AVG(oi.freight_value), 2) AS frete_medio_estado
    FROM olist_orders_dataset o
    JOIN olist_customers_dataset c ON o.customer_id = c.customer_id
    JOIN olist_order_items_dataset oi ON o.order_id = oi.order_id
    GROUP BY c.customer_state
),
frete_geral AS (
    SELECT 
        ROUND(AVG(freight_value), 2) AS frete_medio_geral
    FROM olist_order_items_dataset
)
SELECT 
    e.customer_state,
    e.frete_medio_estado,
    g.frete_medio_geral,
    ROUND(e.frete_medio_estado - g.frete_medio_geral, 2) AS diferenca_media
FROM frete_por_estado e
CROSS JOIN frete_geral g
ORDER BY e.frete_medio_estado DESC;