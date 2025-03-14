{{
    config(
        tags = ['pre-mart','new_logos_count_3_month']
    )
}}

WITH first_purchase AS (
    SELECT
        customer_id,
        customer_name,
        MIN(payment_month) AS first_purchase_date,
        MONTH(first_purchase_date) AS month
    FROM
        {{ ref('int_full') }}
    GROUP BY customer_id,customer_name
)

SELECT
    year(first_purchase_date) AS year,
    CASE
        WHEN month<=3  THEN '1Q'
        WHEN month<=6 and month>3 THEN '2Q'
        WHEN month<=9 and month>6 THEN '3Q'
        ELSE '4Q'
    END AS quarters,
    count(customer_id) AS number_of_new_customers,
FROM 
    first_purchase
GROUP BY
    year,quarters
ORDER BY 
    year,quarters