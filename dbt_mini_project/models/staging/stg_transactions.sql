SELECT 
    customer_id::INTEGER AS customer_id,
    product_id AS product_id,
    payment_month, 
    revenue_type::INTEGER AS revenue_type,
    revenue::FLOAT AS revenue,
    quantity::INTEGER AS quantity,
    dimension_1,
    dimension_2,
    dimension_3,
    dimension_4,
    dimension_5,
    dimension_6,
    dimension_7,
    dimension_8,
    dimension_9,
    dimension_10,
    companies AS companies
FROM {{ source('raw', 'raw_transactions') }}
WHERE
customer_id IS NOT NULL

