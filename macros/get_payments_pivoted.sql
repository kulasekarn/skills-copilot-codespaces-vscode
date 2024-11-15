{% macro get_payments_pivoted(database, schema, prefix) %}

    {# set schema_pattern = 'dbo' #}
    {# set table_pattern = 'int%' #}

    {%- set tables = dbt_utils.get_relations_by_prefix(database=database, schema=schema, prefix=prefix) -%}

    {% for table in tables %}
        select * from {{ table.schema }}.{{ table.name }}
    {% endfor %}

{% endmacro %}