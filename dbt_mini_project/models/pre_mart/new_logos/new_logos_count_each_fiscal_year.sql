{{
    config(
        tags = ['pre-mart','new_logos_count']
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
    year(first_purchase_date) AS fiscal_year,
    count(customer_id) AS number_of_new_customers
FROM 
    first_purchase
GROUP BY
    fiscal_year
ORDER BY 
    fiscal_year
