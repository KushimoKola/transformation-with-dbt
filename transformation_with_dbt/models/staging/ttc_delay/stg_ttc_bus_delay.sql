with source as (
    select *
    from
        {{ source('toronto_transit_commission_delay_data', 'ttc_bus_delay_data') }}
),

final as (
    select
        bound,
        date,
        gap,
        day,
        delay,
        line,
        incident,
        vehicle::varchar as vehicle,
        location,
        location_full,
        time

    from source
)

select * from final
