SELECT
    t.customer_id,
    c.customer_name,
    c.company_name,
    t.product_id,
    t.payment_month,
    t.revenue_type,
    (t.revenue*t.quantity) AS total_revenue
FROM
{{ ref('stg_transactions') }} AS t
LEFT JOIN
{{ ref('stg_customers' )}} AS c
ON
c.customer_id = t.customer_id