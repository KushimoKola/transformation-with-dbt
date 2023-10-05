WITH final AS (
    SELECT DISTINCT
        shelter_id,
        COALESCE (shelter_group, 'Not Available') AS shelter_group

    FROM {{ ref('stg_toronto_shelter_occupancy') }}
)
SELECT * FROM final