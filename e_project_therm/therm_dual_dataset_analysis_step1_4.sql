SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SET therm_set_id = SELECT therm_set_id FROM therm_set_sensor WHERE therm_set_sensor_id = $therm_set_sensor_id::INTEGER;
SET room_id = SELECT  room_id FROM therm_set WHERE therm_set_id=$therm_set_id::INTEGER;
SET building_id = SELECT  building_id FROM project_building_rooms WHERE room_id=$room_id::INTEGER;
SET project_id = SELECT  project_id FROM project_building WHERE building_id=$building_id::INTEGER;


SELECT 
    'breadcrumb' as component;
SELECT 
    'Home' as title,
    '/'    as link;
SELECT 
    'Gestion Superviseur'         as title,
    '/a_panels/panel_supervisor_4.sql' as link;
 SELECT 
    'Projets'            as title,
    '/e_project/project_main_display_4.sql'     as link; 
SELECT 
    'hub du projet'            as title,
    '/e_project/project_hub_display_4.sql?project_id='||$project_id     as link;    
 SELECT 
    'Campagne'            as title,
    '/e_project_therm/therm_set_display_4.sql?project_id='||$project_id     as link;   
 SELECT 
    'Capteur'            as title,
    '/e_project_therm/therm_set_sensor_display_4.sql?therm_set_id='||$therm_set_id     as link;   
 SELECT 
    'Dataset'            as title,
    '/e_project_therm/therm_dataset_display_4.sql?therm_set_sensor_id='||$therm_set_sensor_id    as link; 

SELECT 
    'form' as component,
    'Choisir les jeux de données à comparer' as title,
    'Créer' as validate,
    'Clear' as reset,
    '/e_project_therm/therm_dual_dataset_analysis_create_0.sql?therm_set_sensor_id='||$therm_set_sensor_id as action;

SELECT 
    'Capteur_name'   AS name,
    'text'                        AS type,
    true as readonly,
    12                           AS width,
    'désignation du capteur ex: sensor int' as description,
    (SELECT therm_sensor_name   FROM therm_sensor as s
    LEFT JOIN (SELECT therm_sensor_id, therm_set_sensor_id, therm_set_id FROM therm_set_sensor) as t
    ON s.therm_sensor_id = t.therm_sensor_id
    WHERE t.therm_set_sensor_id=$therm_set_sensor_id::INTEGER) as value,
    'Nom du capteur'                         AS label;

SELECT
    'dataset1'                 as name,
    'Jeu de données 1'          as label,
    'select'                                as type,
    6                                     AS width,
    'Choisir une date dans la liste...'    AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label', therm_dataset_name, 'value', therm_dataset_id)) AS options
    FROM therm_dataset
    WHERE therm_set_sensor_id=$therm_set_sensor_id::INTEGER;

SELECT
    'dataset2'                 as name,
    'Jeu de données 2'          as label,
    'select'                                as type,
    6                                    AS width,
    'Choisir une date dans la liste...'    AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label', therm_dataset_name, 'value', therm_dataset_id)) AS options
    FROM therm_dataset
    WHERE therm_set_sensor_id=$therm_set_sensor_id::INTEGER;