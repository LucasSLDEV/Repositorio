-- 1. Faturamento total por estado do cliente.
-- Avalia qual estado gera maior receita bruta com base nos valores dos itens comercializados.
SELECT 
    c.customer_state,
    SUM(oi.price) AS faturamento_total
FROM olist_customers_dataset c
JOIN olist_orders_dataset o ON c.customer_id = o.customer_id
JOIN olist_order_items_dataset oi ON o.order_id = oi.order_id
GROUP BY c.customer_state
ORDER BY faturamento_total DESC;

-- 2. Top 10 vendedores por faturamento.
-- Identifica os vendedores de maior relevância financeira para a plataforma.
SELECT 
    oi.seller_id,
    SUM(oi.price) AS faturamento_total
FROM olist_order_items_dataset oi
GROUP BY oi.seller_id
ORDER BY faturamento_total DESC
LIMIT 10;

-- 3. Ticket médio por categoria de produto.
-- Calcula o valor médio gasto em itens de cada categoria traduzida para o português.
SELECT 
    pct.product_category_name_english AS categoria,
    ROUND(AVG(oi.price), 2) AS ticket_medio
FROM olist_order_items_dataset oi
JOIN olist_products_dataset p ON oi.product_id = p.product_id
JOIN product_category_name_translation pct ON p.product_category_name = pct.product_category_name
GROUP BY pct.product_category_name_english
ORDER BY ticket_medio DESC;

-- 4. Vendedores com nota média de avaliação abaixo de 3.
-- Filtra parceiros com baixa reputação na plataforma para análise de qualidade de serviço.
SELECT 
    oi.seller_id,
    ROUND(AVG(r.review_score), 2) AS nota_media
FROM olist_order_items_dataset oi
JOIN olist_order_reviews_dataset r ON oi.order_id = r.order_id
GROUP BY oi.seller_id
HAVING AVG(r.review_score) < 3
ORDER BY nota_media ASC;

-- 5. Quantidade de pedidos por forma de pagamento.
-- Mapeia a preferência de método de pagamento utilizada pelos compradores.
SELECT 
    op.payment_type,
    COUNT(DISTINCT op.order_id) AS total_pedidos
FROM olist_order_payments_dataset op
GROUP BY op.payment_type
ORDER BY total_pedidos DESC;

-- 6. Peso médio dos produtos por categoria.
-- Analisa a dimensão e peso médio de cada tipo de produto para fins logísticos.
SELECT 
    pct.product_category_name_english AS categoria,
    ROUND(AVG(p.product_weight_g), 2) AS peso_medio_gramas
FROM olist_products_dataset p
JOIN product_category_name_translation pct ON p.product_category_name = pct.product_category_name
GROUP BY pct.product_category_name_english
ORDER BY peso_medio_gramas DESC;

-- 7. Número médio de parcelas por categoria de produto.
-- Identifica se categorias de maior valor demandam maior parcelamento nas compras.
SELECT 
    pct.product_category_name_english AS categoria,
    ROUND(AVG(op.payment_installments), 2) AS media_parcelas
FROM olist_products_dataset p
JOIN product_category_name_translation pct ON p.product_category_name = pct.product_category_name
JOIN olist_order_items_dataset oi ON p.product_id = oi.product_id
JOIN olist_order_payments_dataset op ON oi.order_id = op.order_id
GROUP BY pct.product_category_name_english
ORDER BY media_parcelas DESC;