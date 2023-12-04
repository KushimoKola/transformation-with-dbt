WITH final AS (
    SELECT DISTINCT
        {{ dbt_utils.generate_surrogate_key(['sector']) }} AS sector_guid,
        sector AS sector_name
    FROM {{ ref('stg_toronto_shelter_occupancy') }}
)

SELECT * FROM final
