{% snapshot snapshot_order %}
    {{
        config(
            target_schema='snapshot',
            target_database='dbt_training_db',
            unique_key='id',
            strategy='timestamp',
            invalidate_hard_deletes=False,
            updated_at='updated_at_field'
        )
    }}

    select * from {{ source('jaffle_shop', 'src_orders') }}
 {% endsnapshot %}