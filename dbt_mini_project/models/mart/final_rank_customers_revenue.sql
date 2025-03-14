{{
    config(
        tags = ['mart']
    )
}}

SELECT
    *
FROM
    {{ ref('rank_customers_basedOn_revenue') }}