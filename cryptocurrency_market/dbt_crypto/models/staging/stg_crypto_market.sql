{{ config(
    schema='analytic'
) }}

with raw as (
    select
        id,
        symbol,
        name,
        current_price,
        market_cap,
        total_volume,
        last_updated
    from {{ source('snowflake', 'CRYPTO_MARKET') }}
)

select
    id,
    upper(symbol) as symbol,
    name,
    current_price,
    market_cap,
    total_volume,
    cast(last_updated as timestamp) as last_updated
from raw
