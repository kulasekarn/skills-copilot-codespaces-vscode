{% set old_relation = adapter.get_relation(
      database = "dbt_training_db",
      schema = "dbo",
      identifier = "customer_orders"
) -%}

{% set dbt_relation = ref('fct_customer_orders') %}

{{ audit_helper.compare_and_classify_relation_rows(
    a_relation = old_relation,
    b_relation = dbt_relation,
    primary_key_columns = ["order_id"],
    columns = ["order_id"]
) }}
