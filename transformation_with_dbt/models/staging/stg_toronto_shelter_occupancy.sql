with source as (
    SELECT * FROM {{ source('shelter_occupancy', 'toronto_shelter_occupancy')}}
),

final as (
    select 
        idempotent_key,
        _id as guid,
        occupancy_date::date as occupancy_date,
        capacity_actual_bed::int as capacity_actual_bed,
        capacity_actual_room::int as capacity_actual_room,
        capacity_funding_bed::int as capacity_funding_bed,
        capacity_funding_room::int as capacity_funding_room,
        capacity_type,
        location_id,
        location_address,
        location_city,
        location_name,
        location_postal_code,
        location_province,
        occupancy_rate_beds::int as occupancy_rate_beds,
        occupancy_rate_rooms_::int as occupancy_rate_rooms,
        occupied_beds::int as occupied_beds,
        occupied_rooms::int as occupied_rooms,
        organization_id,
        organization_name,
        overnight_service_type,
        program_id,
        program_area,
        program_model,
        program_name,
        sector,
        service_user_count::int as service_user_count,
        shelter_id,
        shelter_group,
        unavailable_beds::int as unavailable_beds,
        unavailable_rooms::int as unavailable_rooms,
        unoccupied_beds::int as unoccupied_beds,
        unoccupied_rooms::int as unoccupied_rooms
    
    from source
)

select * from final