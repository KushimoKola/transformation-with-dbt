with source as (
    select *
    from
        {{ source('toronto_transit_commission_delay_data', 'ttc_subway_delay_data') }}
),

final as (
    select
        min_delay,
        bound,
        time,
        vehicle,
        min_gap,
        location_full,
        day,
        location,
        code,
        date,
        line

    from source
)

select * from final
