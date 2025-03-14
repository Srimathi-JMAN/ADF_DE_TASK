{{
    config(
        tags = ['mart']
    )
}}

SELECT
    *
FROM
    {{ ref('churn_customers_LM') }}
