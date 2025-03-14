SELECT
t.customer_id,
p.product_id,
p.product_family,
p.product_sub_family,
t.revenue_type,
t.payment_month,
LAG(payment_month) OVER(PARTITION BY customer_id ORDER BY payment_month) as previous_month,
revenue*quantity AS total_revenue,
LAG(total_revenue) OVER(PARTITION BY customer_id ORDER BY payment_month) as previous_revenue,

FROM 
    {{ ref('stg_transactions')}} AS t
LEFT JOIN 
    {{ ref('stg_products')}} AS p
ON 
    t.product_id = p.product_id
