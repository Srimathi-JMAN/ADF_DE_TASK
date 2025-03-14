WITH revenue_table AS (
    SELECT
        customer_id,
        product_id,
        product_family,
        product_sub_family,
        payment_month,
        LAG(payment_month) OVER(PARTITION BY customer_id,product_id,product_family,product_sub_family ORDER BY payment_month) AS previous_month,
        payment_month AS present_month,
        LEAD(payment_month) OVER(PARTITION BY customer_id,product_id,product_family,product_sub_family ORDER BY payment_month) AS next_month,
        {{ datediff('previous_month','present_month') }} AS difference_prev_current,
        LAG(total_revenue) OVER(PARTITION BY customer_id,product_id,product_family,product_sub_family ORDER BY payment_month) AS previous_revenue,
        total_revenue AS current_revenue,
        LAG(total_revenue) OVER (PARTITION BY customer_id,product_id,product_family,product_sub_family ORDER BY payment_month) AS next_revenue
    FROM 
        {{ ref('int_prod_trans')}}
)

SELECT 
    r1.product_id,
    r1.present_month,
    SUM(r1.current_revenue-r2.current_revenue) AS cross_sell_revenue
FROM 
    revenue_table as r1
INNER JOIN
    revenue_table as r2
ON
    r1.customer_id = r2.customer_id
AND
    r1.product_id <> r2.product_id
AND
    {{ datediff('r1.present_month','r2.present_month') }}<31
AND
    r1.current_revenue>r2.current_revenue
GROUP BY
    r1.product_id,
    r1.present_month
ORDER BY
    cross_sell_revenue DESC,r1.present_month
