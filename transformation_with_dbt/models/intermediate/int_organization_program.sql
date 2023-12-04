WITH souce_table AS (
    SELECT
        program_id,
        program_name,
        organization_id,
        organization_name
    FROM {{ ref('stg_toronto_shelter_occupancy') }}
),

program AS (
    SELECT
        program_guid,
        program_id,
        program_name
    FROM {{ ref('dim_program') }}
),

organization AS (
    SELECT
        organization_guid,
        organization_id,
        organization_name
    FROM {{ ref('dim_organization') }}
),

final AS (
    SELECT DISTINCT
        {{ dbt_utils.generate_surrogate_key(['program_guid', 'organization_guid']) }} AS organization_program_guid,
        b.program_guid,
        c.organization_guid
    FROM
        souce_table AS a
        INNER JOIN program AS b
            ON
                a.program_id = b.program_id
                AND COALESCE(a.program_name, 'Not Specified') = b.program_name
        INNER JOIN organization AS c
            ON
                a.organization_id = c.organization_id
                AND a.organization_name = c.organization_name
)

SELECT * FROM final
