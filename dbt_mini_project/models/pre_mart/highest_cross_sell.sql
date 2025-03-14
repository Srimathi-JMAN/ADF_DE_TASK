SELECT
    customer_id,
    customer_name,
    COUNT(DISTINCT(product_id)) AS number_of_cross_sells
FROM
    {{ ref('int_cust_trans') }}
GROUP BY
    customer_id,
    customer_name
ORDER BY
    number_of_cross_sells DESC,customer_id