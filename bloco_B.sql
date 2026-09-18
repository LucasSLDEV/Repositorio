-- BLOCO B: JOINS

-- 1. Relatório relacionando a categoria do produto traduzida, o valor comercializado do item e a cidade de origem do vendedor.
SELECT 
    t.product_category_name_english AS categoria_traduzida,
    i.price AS valor_item,
    s.seller_city AS cidade_vendedor
FROM olist_order_items_dataset i
JOIN olist_products_dataset p 
  ON i.product_id = p.product_id
JOIN product_category_name_translation t 
  ON p.product_category_name = t.product_category_name
JOIN olist_sellers_dataset s 
  ON i.seller_id = s.seller_id; 

-- 2. Identificação de pedidos entregues com atraso, comparando a data limite estimada com a data real de entrega.
SELECT 
    o.order_id,
    c.customer_unique_id,
    c.customer_city,
    c.customer_state,
    o.order_delivered_customer_date AS data_entrega_real,
    o.order_estimated_delivery_date AS data_entrega_estimada
FROM olist_orders_dataset o
JOIN olist_customers_dataset c 
  ON o.customer_id = c.customer_id
WHERE o.order_status = 'delivered'
  AND o.order_delivered_customer_date > o.order_estimated_delivery_date;

-- 3. Mapeamento de pedidos e suas formas de pagamento, destacando o número de parcelas e valor pago.
SELECT 
    o.order_id,
    o.order_status,
    o.order_purchase_timestamp,
    p.payment_type,
    p.payment_installments,
    p.payment_value
FROM olist_orders_dataset o
JOIN olist_order_payments_dataset p 
  ON o.order_id = p.order_id;

-- 4. Listagem de produtos com tradução da categoria, preservando os itens sem tradução cadastrada.
SELECT 
    p.product_id,
    p.product_category_name AS categoria_original,
    t.product_category_name_english AS categoria_ingles
FROM olist_products_dataset p
LEFT JOIN product_category_name_translation t 
  ON p.product_category_name = t.product_category_name;

-- 5. Mapeamento de vendas locais onde o cliente e o vendedor pertencem ao mesmo estado.
SELECT 
    o.order_id,
    c.customer_state AS estado_cliente,
    s.seller_state AS estado_vendedor
FROM olist_orders_dataset o
JOIN olist_customers_dataset c 
  ON o.customer_id = c.customer_id
JOIN olist_order_items_dataset i 
  ON o.order_id = i.order_id
JOIN olist_sellers_dataset s 
  ON i.seller_id = s.seller_id
WHERE c.customer_state = s.seller_state;
