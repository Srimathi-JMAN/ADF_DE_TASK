{{
    config(
        tags = ['pre-mart','new_logos_count_month']
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
    count(customer_id) AS number_of_new_customers
FROM 
    first_purchase
GROUP by
    year,month
ORDER BY 
    year,month