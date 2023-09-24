with source as (
    SELECT * FROM {{ source('toronto_transit_commission_delay_data', 'ttc_streetcar_delay_data')}}
),
final as (
    select 
        time,
        gap,
        incident,
        date,
        location_full,
        vehicle,
        line,
        day,
        bound,
        delay,
        location
        
    from source
)
select * from final