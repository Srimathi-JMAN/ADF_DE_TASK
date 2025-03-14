{{
    config(
        tags = ['pre-mart','rank_customers_revenue']
    )
}}

SELECT
    customer_id,
    customer_name,
    sum(total_revenue) as revenue,
    DENSE_RANK() OVER(ORDER BY revenue DESC) AS rank_number
FROM
    {{ ref('int_cust_trans')}}
GROUP BY 
    customer_id,
    customer_name
