WITH churn_customers AS (
    SELECT
        customer_id,
        previous_month,
        payment_month,
        revenue_type,
        month(payment_month) AS month,
        year(payment_month) AS year,
        {{ datediff('previous_month','payment_month') }} AS difference,
        CASE 
            WHEN difference>90 THEN 'churned'
            ELSE 'not churned'
        END AS churned_or_not
    FROM
        {{ ref('int_prod_trans') }}
    WHERE
        revenue_type=1
)

SELECT 
    year,
    CASE
        WHEN month<=3 THEN 'Q1'
        WHEN month>3 and month<=6 THEN 'Q2'
        WHEN month>6 and month<=9 THEN 'Q3'
        ELSE 'Q4'
    END AS quarters,
    COUNT(customer_id) AS number_of_churned_customers,
FROM   
    churn_customers
WHERE 
    churned_or_not='churned'
GROUP BY
    year,quarters
ORDER BY 
    year,quarters
