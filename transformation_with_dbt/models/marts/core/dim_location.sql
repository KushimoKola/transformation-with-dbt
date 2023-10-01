WITH shelter_location AS (
    SELECT
        location_address AS street,
        location_city AS city,
        location_postal_code AS postal_code,
        location_province AS province
    FROM {{ ref('stg_toronto_shelter_occupancy') }}
),
deduplicate_non_matching_location AS (
    SELECT
        location_postal_code,
        location_address_1,
        location_address_2
    FROM {{ ref('int_duplicate_non_matching_location') }}
),
merged_location AS (
    SELECT
        a.city,
        a.postal_code,
        a.province,
        b.location_address_1,
        b.location_address_2
    FROM shelter_location AS a 
    INNER JOIN deduplicate_non_matching_location AS b 
    ON a.postal_code = b.location_postal_code
),
unpivoted_location AS (
    SELECT
        city,
        postal_code,
        province,
        street
    FROM merged_location
    UNPIVOT (street FOR locations in (location_address_1, location_address_2))
),
final AS (
    SELECT DISTINCT
       /*Ideally, POSTAL_CODE and STREET would have been fine, but we had to 
       PROVINCE, just in case a shelter exists in another province with same
       street address, though this is unlikely for postal code. 
       Including city would have created ambigous key, particularly for cases
       such as 'M5A 2N3'
        */
        {{ dbt_utils.generate_surrogate_key(['postal_code', 'street', 'province']) }} AS location_guid,
        street,
        city,
        postal_code,
        province,
        CONCAT(street, ', ', city, ', ', province, ', ', postal_code) AS shelter_address
    FROM unpivoted_location
    WHERE street IS NOT NULL
)
SELECT * FROM final
