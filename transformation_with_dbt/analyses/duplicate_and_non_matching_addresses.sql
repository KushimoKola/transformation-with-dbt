WITH DeduplicatedAddresses AS (
    SELECT DISTINCT
        TRIM(location_postal_code) AS location_postal_code,
        TRIM(location_address) AS location_address
    FROM {{ ref('stg_toronto_shelter_occupancy') }} as a
    WHERE location_postal_code IS NOT NULL
),
MatchingAddresses AS (
    SELECT
        location_postal_code,
        location_address
    FROM DeduplicatedAddresses
    QUALIFY ROW_NUMBER() OVER (PARTITION BY location_postal_code ORDER BY location_address DESC) = 1
),
NonMatchingAddresses AS (
    SELECT
        location_postal_code,
        location_address
    FROM DeduplicatedAddresses
    QUALIFY ROW_NUMBER() OVER (PARTITION BY location_postal_code ORDER BY location_address DESC) > 1
),
CombinedAddresses AS (
    SELECT
        da.location_postal_code,
        ma.location_address AS location_address_1,
        na.location_address AS location_address_2
    FROM DeduplicatedAddresses da
    LEFT OUTER JOIN MatchingAddresses ma ON da.location_postal_code = ma.location_postal_code
    LEFT OUTER JOIN NonMatchingAddresses na ON da.location_postal_code = na.location_postal_code
),
FinalAddresses AS (
    SELECT
        location_postal_code,
        location_address_1,
        /*For addresses that were mispelled, this logic compare the first 2 words
        in each of the address we have classified, if the result matches using the 
        regexp logic, we return null, else, location_address_2
        Then we dedupped using with the qualify function. 
        */
        CASE
            WHEN 
            REGEXP_SUBSTR(location_address_1, '\\b\\w+\\b', 1, 1) = REGEXP_SUBSTR(location_address_2, '\\b\\w+\\b', 1, 1)
            AND 
            REGEXP_SUBSTR(location_address_1, '\\b\\w+\\b', 1, 2) = REGEXP_SUBSTR(location_address_2, '\\b\\w+\\b', 1, 2)
            THEN NULL 
            ELSE location_address_2
        END AS location_address_2
    FROM CombinedAddresses
    QUALIFY ROW_NUMBER() OVER (PARTITION BY location_postal_code ORDER BY location_postal_code DESC) = 1
)
SELECT
    location_postal_code,
    location_address_1,
    location_address_2
FROM FinalAddresses;
