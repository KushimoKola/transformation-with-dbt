with source as (
    SELECT * FROM {{ source('toronto_transit_commission_delay_data', 'ttc_bus_delay_data')}}
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
        
    FROM source
)
select * from final