SET user_role = (
    SELECT user_role FROM users
    INNER JOIN sessions ON users.user_id = sessions.user_id
    WHERE sessions.session_token = sqlpage.cookie('session_token')
); 

SET redirect_link =
CASE WHEN $user_role = 'supervisor' 
THEN  '/e_project_therm/therm_set_sensor_display_4.sql?therm_set_id='||$therm_set_id
ELSE  '/e_project_therm/therm_set_sensor_display_3.sql?therm_set_id='||$therm_set_id
END;

WITH sensor_raw AS (
    SELECT
        sqlpage.read_file_as_text(
            sqlpage.uploaded_file_path('therm_set_sensor_point')
        )::jsonb AS geojson
),
sensor AS (
    SELECT
        geojson -> 'geometry' AS geom_json
    FROM sensor_raw
)
INSERT INTO therm_set_sensor
(
    therm_set_id,
    therm_sensor_id,
    therm_set_sensor_point,
    therm_set_sensor_description,
    therm_set_sensor_status
)
SELECT
    $therm_set_id::INTEGER,
    :therm_sensor_id::INTEGER,
    ST_SetSRID(
        ST_GeomFromGeoJSON(geom_json::text),
        4326
    ),
    :therm_set_sensor_description,
    'active'
FROM sensor;

SET therm_set_sensor_id = SELECT MAX(therm_set_sensor_id) FROM therm_set_sensor WHERE therm_sensor_id=:therm_sensor_id::INTEGER;
SET therm_sensor_name = SELECT  therm_sensor_name FROM therm_sensor WHERE therm_sensor_id=:therm_sensor_id::INTEGER;
SET therm_set_sensor_name = SELECT CONCAT($therm_set_sensor_id::text,'-',$therm_sensor_name::text) FROM therm_sensor WHERE therm_sensor_id=:therm_sensor_id::INTEGER;

UPDATE therm_set_sensor
SET therm_set_sensor_name = $therm_set_sensor_name
WHERE therm_set_sensor_id=$therm_set_sensor_id::INTEGER
RETURNING 'redirect' AS component,
$redirect_link  AS link;