WITH source_table AS (
    SELECT
        shelter_id,
        location_postal_code,
        location_address,
        location_province
    FROM {{ ref('stg_toronto_shelter_occupancy') }}
),

location AS (
    SELECT
        location_guid,
        postal_code,
        street,
        province
    FROM {{ ref('dim_location') }}
),

shelter AS (
    SELECT shelter_id
    FROM {{ ref('dim_shelter') }}
),

final AS (
    SELECT DISTINCT
        {{ dbt_utils.generate_surrogate_key(['c.shelter_id', 'b.location_guid']) }} AS location_shelter_guid,
        c.shelter_id,
        b.location_guid
    FROM
        source_table AS a
        INNER JOIN location AS b
            ON
                a.location_postal_code = b.postal_code
                AND a.location_address = b.street
                AND a.location_province = b.province
        INNER JOIN shelter AS c
            ON a.shelter_id = c.shelter_id
)

SELECT * FROM final
