WITH final AS (
    SELECT DISTINCT
        {{ dbt_utils.generate_surrogate_key(['shelter_id']) }}
            AS shelter_guid,
        shelter_id,
        COALESCE(shelter_group, 'Not Available') AS shelter_group

    FROM {{ ref('stg_toronto_shelter_occupancy') }}
)

SELECT * FROM final
