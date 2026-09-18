-- 1. Clientes cujo gasto total está acima da média geral de gasto por cliente.
-- Compara o gasto acumulado de cada cliente individual com a média calculada sobre todos os clientes.
SELECT 
    c.customer_unique_id,
    SUM(oi.price) AS gasto_total
FROM olist_customers_dataset c
JOIN olist_orders_dataset o ON c.customer_id = o.customer_id
JOIN olist_order_items_dataset oi ON o.order_id = oi.order_id
GROUP BY c.customer_unique_id
HAVING SUM(oi.price) > (
    SELECT AVG(gasto_cliente)
    FROM (
        SELECT SUM(oi_sub.price) AS gasto_cliente
        FROM olist_customers_dataset c_sub
        JOIN olist_orders_dataset o_sub ON c_sub.customer_id = o_sub.customer_id
        JOIN olist_order_items_dataset oi_sub ON o_sub.order_id = oi_sub.order_id
        GROUP BY c_sub.customer_unique_id
    ) sub
)
ORDER BY gasto_total DESC;

-- 2. Produtos que nunca receberam avaliação (NOT EXISTS / NOT IN).
-- Identifica itens cadastrados no catálogo que não possuem nenhum registro correspondente na tabela de avaliações.
SELECT 
    p.product_id,
    pct.product_category_name_english AS categoria
FROM olist_products_dataset p
LEFT JOIN product_category_name_translation pct ON p.product_category_name = pct.product_category_name
WHERE NOT EXISTS (
    SELECT 1 
    FROM olist_order_items_dataset oi
    JOIN olist_order_reviews_dataset r ON oi.order_id = r.order_id
    WHERE oi.product_id = p.product_id
);

-- 3. Vendedores que venderam produtos de mais de 5 categorias diferentes.
-- Filtra parceiros comerciais que possuem alta diversidade no catálogo ofertado à plataforma.
SELECT 
    seller_id
FROM olist_order_items_dataset
WHERE seller_id IN (
    SELECT oi.seller_id
    FROM olist_order_items_dataset oi
    JOIN olist_products_dataset p ON oi.product_id = p.product_id
    WHERE p.product_category_name IS NOT NULL
    GROUP BY oi.seller_id
    HAVING COUNT(DISTINCT p.product_category_name) > 5
)
GROUP BY seller_id;

-- 4. Pedidos cujo valor de frete é maior que o valor total dos itens do próprio pedido (subquery correlacionada).
-- Localiza transações atípicas em que a logística superou o custo monetário da mercadoria adquirida.
SELECT 
    o.order_id,
    c.customer_id
FROM olist_orders_dataset o
JOIN olist_customers_dataset c ON o.customer_id = c.customer_id
WHERE (
    SELECT SUM(oi.freight_value) 
    FROM olist_order_items_dataset oi 
    WHERE oi.order_id = o.order_id
) > (
    SELECT SUM(oi.price) 
    FROM olist_order_items_dataset oi 
    WHERE oi.order_id = o.order_id
);