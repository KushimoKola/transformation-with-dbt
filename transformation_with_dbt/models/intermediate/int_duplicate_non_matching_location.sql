WITH deduplicated_addresses AS (
    SELECT DISTINCT
        location_id,
        location_postal_code,
        location_address
    FROM {{ ref('stg_toronto_shelter_occupancy') }}
    WHERE location_postal_code IS NOT NULL
),

matching_addresses AS (
    SELECT
        location_id,
        location_postal_code,
        location_address
    FROM deduplicated_addresses
    QUALIFY
        ROW_NUMBER()
            OVER (
                PARTITION BY location_postal_code ORDER BY location_address DESC
            )
        = 1
),

nonmatching_addresses AS (
    SELECT
        location_id,
        location_postal_code,
        location_address
    FROM deduplicated_addresses
    QUALIFY
        ROW_NUMBER()
            OVER (
                PARTITION BY location_postal_code ORDER BY location_address DESC
            )
        > 1
),

combined_addresses AS (
    SELECT
        da.location_id,
        da.location_postal_code,
        ma.location_postal_code AS location_postal_code_2,
        ma.location_address AS location_address_1,
        na.location_address AS location_address_2
    FROM deduplicated_addresses AS da
        LEFT OUTER JOIN
            matching_addresses AS ma
            ON da.location_postal_code = ma.location_postal_code
        LEFT OUTER JOIN
            nonmatching_addresses AS na
            ON da.location_postal_code = na.location_postal_code
),

final_addresses AS (
    SELECT
        location_id,
        location_postal_code,
        location_address_1,
        /*For addresses that were mispelled, this logic compare the first 2 words
        in each of the address we have classified, if the result matches using the
        regexp logic, we return null, else, location_address_2
        Then we dedupped using with the qualify function.
        */
        CASE
            WHEN
                REGEXP_SUBSTR(location_address_1, '\\b\\w+\\b', 1, 1)
                = REGEXP_SUBSTR(location_address_2, '\\b\\w+\\b', 1, 1)
                AND
                REGEXP_SUBSTR(location_address_1, '\\b\\w+\\b', 1, 2)
                = REGEXP_SUBSTR(location_address_2, '\\b\\w+\\b', 1, 2)
                AND
                -- Some addresses where wrongly captured (e.g M5A 2N3), this condition helped correct that.
                location_postal_code = location_postal_code_2
                THEN NULL
            ELSE location_address_2
        END AS location_address_2
    FROM combined_addresses
    QUALIFY
        ROW_NUMBER()
            OVER (
                PARTITION BY location_postal_code
                ORDER BY location_postal_code DESC
            )
        = 1
),

unpivot_location AS (
    SELECT
        location_id,
        location_postal_code AS postal_code,
        street
    FROM final_addresses
        UNPIVOT (
            street FOR locations IN (location_address_1, location_address_2)
        )
),

final AS (
    SELECT
        postal_code,
        street
    FROM unpivot_location
)

SELECT * FROM final
