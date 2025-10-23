{{ config(
    schema='analytic',
    materialized='table'
) }}

with base as (
    select
        id,
        symbol,
        name,
        current_price,
        market_cap,
        total_volume,
        last_updated
    from {{ ref('stg_crypto_market') }}
),

ranked as (
    select
        *,
        row_number() over (partition by symbol order by last_updated desc) as rn
    from base
)

select
    id,
    symbol,
    name,
    current_price,
    market_cap,
    total_volume,
    last_updated,
    case 
        when market_cap > 1000000000 then 'Large Cap'
        when market_cap > 100000000 then 'Mid Cap'
        else 'Small Cap'
    end as market_cap_category
from ranked
where rn = 1
