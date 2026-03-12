SET therm_set_id = SELECT therm_set_id FROM therm_set_sensor WHERE therm_set_sensor_id = $therm_set_sensor_id::INTEGER;
SET room_id = SELECT room_id FROM therm_set WHERE therm_set_id = $therm_set_id::integer;
SET building_id = SELECT building_id FROM project_building_rooms WHERE room_id = $room_id::integer;
SET project_id = SELECT project_id FROM project_building WHERE building_id = $building_id::integer;


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


-- 1) Lire le GeoJSON uniquement si un fichier a été envoyé
WITH sensor_raw AS (
    SELECT
        CASE
            WHEN sqlpage.uploaded_file_path('therm_set_sensor_point') IS NOT NULL
            THEN sqlpage.read_file_as_text(
                    sqlpage.uploaded_file_path('therm_set_sensor_point')
                 )::jsonb
            ELSE NULL
        END AS geojson
),
sensor AS (
    SELECT
        CASE
            WHEN geojson IS NOT NULL
            THEN geojson -> 'geometry'
            ELSE NULL
        END AS geom_json
    FROM sensor_raw
)

-- 2) UPDATE qui n’écrase pas la géométrie si aucun fichier
UPDATE therm_set_sensor tss
SET
    therm_sensor_id = COALESCE(
        NULLIF(:therm_sensor_id, '')::integer,
        tss.therm_sensor_id
    ),
    therm_set_sensor_description = COALESCE(
        NULLIF(:therm_set_sensor_description, ''),
        tss.therm_set_sensor_description
    ),
    therm_set_sensor_status = COALESCE(
        NULLIF(:therm_set_sensor_status, ''),
        tss.therm_set_sensor_status
    ),
    therm_set_sensor_point = COALESCE(
        (
            SELECT ST_SetSRID(
                       ST_GeomFromGeoJSON(geom_json::text),
                       4326
                   )
            FROM sensor
        ),
        tss.therm_set_sensor_point
    )
WHERE tss.therm_set_sensor_id = $therm_set_sensor_id::integer
RETURNING
    'redirect' AS component,
    $redirect_link AS link;
