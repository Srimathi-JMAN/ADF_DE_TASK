{{
    config(
        tags = ['mart']
    )
}}

SELECT
    *
FROM
    {{ ref('highest_cross_sell') }}