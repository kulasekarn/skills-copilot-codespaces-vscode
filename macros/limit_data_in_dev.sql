{% macro limit_data_in_dev(date_column, days_of_dev_data) %}

{%- if target.name == 'dev' -%}
    where {{ date_column }} >= dateadd(day, -{{ days_of_dev_data }}, cast(current_timestamp as date))
{%- endif %}

{% endmacro %}