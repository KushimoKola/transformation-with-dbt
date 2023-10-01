WITH shelter_organization AS (
    SELECT
        organization_id,
        organization_name
    FROM {{ ref('stg_toronto_shelter_occupancy') }}
),
final AS (
    SELECT DISTINCT
        {{ dbt_utils.generate_surrogate_key(['organization_id', 'organization_name']) }} as organization_guid,
        organization_name
    FROM shelter_organization
)
SELECT * FROM final