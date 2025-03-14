
SELECT t.customer_id, c.customer_name, COUNT(DISTINCT p.product_family) AS unique_product_families
FROM {{ ref('stg_transactions') }} t
JOIN {{ ref('stg_customers') }} c ON t.customer_id = c.customer_id
JOIN {{ ref('stg_products') }} p ON t.product_id = p.product_id
GROUP BY t.customer_id, c.customer_name
ORDER BY unique_product_families DESC
LIMIT 5;
 
WITH last_purchase AS (
    SELECT customer_id, product_id, MAX(payment_month) AS last_purchase_month
    FROM {{ ref('stg_transactions') }}
    GROUP BY customer_id, product_id
)
SELECT t.customer_id, c.customer_name, p.product_family, COUNT(t.product_id) AS times_purchased
FROM last_purchase lp
JOIN {{ ref('stg_transactions') }} t ON lp.customer_id = t.customer_id AND lp.product_id = t.product_id
JOIN {{ ref('stg_customers') }} c ON lp.customer_id = c.customer_id
JOIN {{ ref('stg_products') }} p ON lp.product_id = p.product_id
WHERE NOT EXISTS (
    SELECT 1 FROM {{ ref('stg_transactions') }} t2
    WHERE lp.customer_id = t2.customer_id
    AND lp.product_id = t2.product_id
    AND t2.payment_month > DATEADD(month, 6, lp.last_purchase_month)
)
GROUP BY t.customer_id, c.customer_name, p.product_family
ORDER BY times_purchased DESC
LIMIT 5;