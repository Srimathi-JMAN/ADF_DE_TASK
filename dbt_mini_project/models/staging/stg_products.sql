SELECT
product_id,
product_family,
product_sub_family
FROM
{{ source('raw','raw_products' )}}
WHERE
product_id IS NOT NULL