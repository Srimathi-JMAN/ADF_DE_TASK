{{
    config(
        tags = ['mart']
    )
}}

SELECT
    *
FROM
    {{ ref('rank_products_basedOn_revenue') }}