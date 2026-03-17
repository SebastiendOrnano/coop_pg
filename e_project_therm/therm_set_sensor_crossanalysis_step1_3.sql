SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_3.sql') AS properties;

SET room_id = SELECT room_id FROM therm_set WHERE therm_set_id = $therm_set_id::integer;
SET building_id = SELECT building_id FROM project_building_rooms WHERE room_id = $room_id::integer;
SET project_id = SELECT project_id FROM project_building WHERE building_id = $building_id::integer;

SELECT 
    'breadcrumb' as component;
SELECT 
    'Home' as title,
    '/'    as link;
SELECT 
    'Gestion Editeur'         as title,
    '/a_panels/panel_editor_3.sql' as link;
 SELECT 
    'Projets'            as title,
    '/e_project/project_main_display_3.sql'     as link;   
SELECT 
    'Sensor'            as title,
    '/e_project_therm/therm_sensor_display_3.sql'   as link;  
 SELECT 
    'Hub du projet'            as title,
    '/e_project/project_hub_display_3.sql?project_id='||$project_id     as link;  
SELECT 
    'Campagnes mesure'            as title,
    '/e_project_therm/therm_set_display_3.sql?project_id='||$project_id     as link;
 SELECT 
    'Capteur'            as title,
    '/e_project_therm/therm_set_sensor_display_3.sql?therm_set_id='||$therm_set_id     as link;   

SELECT 
    'form' as component,
    'Choisir les capteurs' as title,
    'Créer' as validate,
    'Clear' as reset,
    '/e_project_therm/therm_set_sensor_crossanalysis_step1_create_0.sql?therm_set_id='||$therm_set_id as action;


SELECT
    'sensor1'                 as name,
    'capteur1'          as label,
    'select'                                as type,
    6                                     AS width,
    'Choisir une date dans la liste...'    AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label', s.therm_set_sensor_name, 'value', s.therm_set_sensor_id)) AS options
    FROM therm_set_sensor as s
    WHERE s.therm_set_id = $therm_set_id::integer;

SELECT
    'sensor2'                 as name,
    'capteur2'          as label,
    'select'                                as type,
    6                                    AS width,
    'Choisir une date dans la liste...'    AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label', s.therm_set_sensor_name, 'value', s.therm_set_sensor_id)) AS options
    FROM therm_set_sensor as s
    WHERE s.therm_set_id = $therm_set_id::integer;