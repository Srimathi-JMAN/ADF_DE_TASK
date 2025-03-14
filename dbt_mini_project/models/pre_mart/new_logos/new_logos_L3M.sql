{{
    config(
        tags = ['pre-mart','new_logos_3_month']
    )
}}

WITH first_purchase AS (
    SELECT
        customer_id,
        customer_name,
        MIN(payment_month) AS first_purchase_date
    FROM
        {{ ref('int_full') }}
    GROUP BY customer_id,customer_name
)

SELECT
    year(first_purchase_date) AS year,
    month(first_purchase_date) AS month,
    CASE
        WHEN month<=3  THEN '1Q'
        WHEN month<=6 and month>3 THEN '2Q'
        WHEN month<=9 and month>6 THEN '3Q'
        ELSE '4Q'
    END AS quarters,
    customer_id,
    customer_name
FROM 
    first_purchase
GROUP BY
    year,month,customer_id,customer_name
ORDER BY 
    year,month,customer_id