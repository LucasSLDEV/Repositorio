-- 1. Classificar pedidos por prazo de entrega: "adiantado", "no prazo" ou "atrasado".
-- Compara a data real de entrega (order_delivered_customer_date) com a data estimada (order_estimated_delivery_date).
SELECT 
    order_id,
    order_delivered_customer_date::DATE AS data_entrega_real,
    order_estimated_delivery_date::DATE AS data_estimada,
    CASE 
        WHEN order_delivered_customer_date::DATE < order_estimated_delivery_date::DATE THEN 'Adiantado'
        WHEN order_delivered_customer_date::DATE = order_estimated_delivery_date::DATE THEN 'No prazo'
        WHEN order_delivered_customer_date::DATE > order_estimated_delivery_date::DATE THEN 'Atrasado'
        ELSE 'Não entregue / Sem informação'
    END AS status_prazo
FROM olist_orders_dataset
WHERE order_status = 'delivered';

-- 2. Classificar clientes por faixa de gasto total: "bronze", "prata", "ouro".
-- Segmenta a carteira de clientes com base no valor total acumulado em compras.
SELECT 
    c.customer_unique_id,
    SUM(oi.price) AS gasto_total,
    CASE 
        WHEN SUM(oi.price) >= 500 THEN 'Ouro'
        WHEN SUM(oi.price) >= 150 AND SUM(oi.price) < 500 THEN 'Prata'
        ELSE 'Bronze'
    END AS categoria_cliente
FROM olist_customers_dataset c
JOIN olist_orders_dataset o ON c.customer_id = o.customer_id
JOIN olist_order_items_dataset oi ON o.order_id = oi.order_id
GROUP BY c.customer_unique_id
ORDER BY gasto_total DESC;

-- 3. Classificar produtos por faixa de peso: "leve", "médio", "pesado".
-- Categoriza os produtos em gramas para auxiliar no direcionamento logístico e cálculo de frete.
SELECT 
    product_id,
    product_weight_g,
    CASE 
        WHEN product_weight_g IS NULL THEN 'Não especificado'
        WHEN product_weight_g <= 1000 THEN 'Leve'           -- Até 1kg
        WHEN product_weight_g <= 5000 THEN 'Médio'          -- De 1kg a 5kg
        ELSE 'Pesado'                                       -- Acima de 5kg
    END AS faixa_peso
FROM olist_products_dataset;

-- 4. Classificar pagamentos como "à vista" ou "parcelado", sinalizando parcelamentos longos (> 6).
-- Agrupa as formas de pagamento para identificar a aceitação e preferência de crédito estendido.
SELECT 
    order_id,
    payment_type,
    payment_installments,
    CASE 
        WHEN payment_installments = 1 THEN 'À vista'
        WHEN payment_installments BETWEEN 2 AND 6 THEN 'Parcelado'
        WHEN payment_installments > 6 THEN 'Parcelado Longo'
        ELSE 'Outros'
    END AS tipo_parcelamento
FROM olist_order_payments_dataset;