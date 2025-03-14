WITH product_churns AS (
    SELECT
        product_id,
        MAX(payment_month) AS last_purchase_date
    FROM
        {{ ref('int_prod_trans') }}
    GROUP BY product_id
)

SELECT
    year(last_purchase_date) AS year,
    product_id AS number_of_product_churns
FROM 
    product_churns
ORDER BY 
    year