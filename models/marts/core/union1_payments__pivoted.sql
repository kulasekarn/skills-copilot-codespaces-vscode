{{
    config(
        required_tests=None
    )
}}

{{ dbt_utils.union_relations(
    relations=[ref('int1_payments__pivoted'), ref('int2_payments__pivoted')],
    source_column_name=None
) }}