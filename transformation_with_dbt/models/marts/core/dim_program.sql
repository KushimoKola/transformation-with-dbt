WITH shelter_program AS (
    SELECT
        program_id,
        COALESCE (program_name, 'Not Specified') AS program_name,
        COALESCE (program_model, 'Not Specified') AS program_model
    FROM {{ ref('stg_toronto_shelter_occupancy') }}
), 
final AS (
    SELECT DISTINCT
        {{ dbt_utils.generate_surrogate_key(['program_id', 'program_name']) }} AS program_guid,
        program_name,
        program_model
    FROM shelter_program
)
SELECT * FROM final