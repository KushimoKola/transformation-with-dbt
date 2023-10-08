WITH source AS (
    SELECT COALESCE(overnight_service_type, 'Not Available') AS service_type
    FROM {{ ref('stg_toronto_shelter_occupancy') }}
),

final AS (
    SELECT DISTINCT
        {{ dbt_utils.generate_surrogate_key(['service_type']) }}
            AS shelter_type_guid,
        service_type
    FROM source
)

SELECT * FROM final
