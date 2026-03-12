SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SET room_id = SELECT room_id FROM therm_set WHERE therm_set_id = $therm_set_id::integer;
SET building_id = SELECT building_id FROM project_building_rooms WHERE room_id = $room_id::integer;
SET project_id = SELECT project_id FROM project_building WHERE building_id = $building_id::integer;

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
    'Campagnes'            as title,
    '/e_project_therm/therm_set_display_4.sql?project_id='||$project_id     as link;    
 SELECT 
    'Capteurs'            as title,
    '/e_project_therm/therm_set_sensor_display_4.sql?therm_set_id='||$therm_set_id     as link;   

SELECT 
    'form' as component,
    'Choisir les jeux de données pour chaque capteur' as title,
    'Créer' as validate,
    'Clear' as reset,
    '/e_project_therm/therm_set_sensor_crossanalysis_create_0.sql?therm_set_id='||$therm_set_id as action;

SELECT 
    'sensor1_id'   AS name,
    'hidden'                        AS type,
    (SELECT therm_sensor_id FROM therm_sensor as s
    WHERE s.therm_sensor_id=:sensor1::INTEGER) as value;
SELECT 
    'sensor2_id'   AS name,
    'hidden'                        AS type,
    (SELECT therm_sensor_id FROM therm_sensor as s
    WHERE s.therm_sensor_id=:sensor2::INTEGER) as value;
SELECT 
    'Capteur1_name'   AS name,
    'text'                        AS type,
    true as readonly,
    6                            AS width,
    'désignation du capteur ex: sensor int' as description,   
    (SELECT therm_sensor_name FROM therm_sensor as s
    WHERE s.therm_sensor_id=:sensor1::INTEGER) as value,  
    'Nom du capteur 1'                         AS label;

SELECT 
    'Capteur2_name'   AS name,
    'text'                        AS type,
    true as readonly,
    6                            AS width,
    'désignation du capteur ex: sensor int' as description,
    (SELECT therm_sensor_name FROM therm_sensor as s
    WHERE s.therm_sensor_id=:sensor2::INTEGER) as value,
    'Nom du capteur 2'                         AS label;

SELECT
    'datasetsensor1'                 as name,
    'dataset (capteur1)'          as label,
    'select'                                as type,
    6                                     AS width,
    'Choisir une date dans la liste...'    AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label', therm_dataset_name, 'value', d.therm_dataset_id)) AS options
    FROM therm_dataset as d
    LEFT JOIN (SELECT therm_sensor_id, therm_set_sensor_id, therm_set_id FROM therm_set_sensor) as t
    ON d.therm_set_sensor_id = t.therm_set_sensor_id
    WHERE t.therm_sensor_id = :sensor1::integer;

SELECT
    'datasetsensor2'                 as name,
    'dataset (capteur2)'          as label,
    'select'                                as type,
    6                                    AS width,
    'Choisir une date dans la liste...'    AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label', therm_dataset_name, 'value', d.therm_dataset_id)) AS options
    FROM therm_dataset as d
    LEFT JOIN (SELECT therm_sensor_id, therm_set_sensor_id, therm_set_id FROM therm_set_sensor) as t
    ON d.therm_set_sensor_id = t.therm_set_sensor_id
    WHERE t.therm_sensor_id = :sensor2::integer;