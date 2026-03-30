SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SET therm_set_id = SELECT therm_set_id FROM therm_set_sensor WHERE therm_set_sensor_id = $therm_set_sensor_id::INTEGER;
SET room_id = SELECT room_id FROM therm_set WHERE therm_set_id = $therm_set_id::integer;
SET building_id = SELECT building_id FROM project_building_rooms WHERE room_id = $room_id::integer;
SET project_id = SELECT project_id FROM project_building WHERE building_id = $building_id::integer;
SET geo_group_id_main = SELECT geo_group_id FROM project_geo_group WHERE project_id=$project_id::INTEGER AND geo_group_rank='main';


SELECT 
    'breadcrumb' as component;
SELECT 
    'Home' as title,
    '/'    as link;
SELECT 
    'Gestion Superviseur'         as title,
    '/a_panels/panel_supervisor_4.sql' as link;
 SELECT 
    'liste des projets'            as title,
    '/e_project/project_main_display_4.sql'     as link;   
 SELECT 
    'hub du projet'            as title,
    '/e_project/project_hub_display_4.sql?project_id='||$project_id     as link;   
 SELECT 
    'Therm'            as title,
    '/e_project_therm/therm_set_display_4.sql?project_id='||$project_id     as link;    
 SELECT 
    'Capteurs'            as title,
    '/e_project_therm/therm_set_sensor_display_4.sql?therm_set_id='||$therm_set_id     as link;    


SELECT 
    'map'   AS component,
    'Localisation du capteur' AS title,
    16 AS zoom,
    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png' AS tile_source;

SELECT 
    geo_title               AS title,
    CASE
    WHEN geo_category = 'building' 
    THEN 'building' 
    ELSE ''
    END AS icon,
    CASE
    WHEN geo_category = 'building' 
    THEN 'green' 
    ELSE 'blue'
    END AS color,
    geo_description AS description,
    'http://localhost:8080/e_project_geo/geo_main_profile_4.sql?geo_id='||geo_id::INTEGER AS link,
    ST_AsGeoJSON(geo_geom)  AS geojson
    FROM project_geo
    WHERE geo_group_id=$geo_group_id_main::INTEGER ;
SELECT 
    therm_sensor_name      AS title,
    'http://localhost:8080/e_project_therm/therm_set_sensor_edit_4.sql?therm_set_sensor_id='||$therm_set_sensor_id::INTEGER AS link,
    ST_AsGeoJSON(s.therm_set_sensor_point)  AS geojson
    FROM therm_sensor AS t
    LEFT JOIN (SELECT therm_sensor_id, therm_set_sensor_id, therm_set_sensor_point FROM therm_set_sensor) AS s
    ON t.therm_sensor_id=s.therm_sensor_id
    WHERE therm_set_sensor_id = $therm_set_sensor_id::integer;