{{
    config(
        tags = ['pre-mart','rank_products_revenue']
    )
}}

SELECT
    product_id,
    product_family,
    sum(total_revenue) AS revenue,
    DENSE_RANK() OVER(ORDER BY revenue DESC) as rank_number
FROM
    {{  ref('int_prod_trans') }}
GROUP BY
    product_id,
    product_family