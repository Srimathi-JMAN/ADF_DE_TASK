{{
    config(
        tags = ['mart']
    )
}}

SELECT
    *
FROM
    {{ ref('new_logos_count_LM') }}