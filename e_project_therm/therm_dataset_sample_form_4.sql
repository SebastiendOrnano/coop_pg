SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SET therm_set_sensor_id = SELECT therm_set_sensor_id FROM therm_dataset  WHERE therm_dataset_id = $therm_dataset_id::integer
SET therm_set_id = SELECT therm_set_id FROM therm_set_sensor WHERE therm_set_sensor_id=$therm_set_sensor_id::INTEGER;
SET room_id = (SELECT room_id FROM therm_set WHERE therm_set_id = $therm_set_id::integer);
SET building_id = (SELECT building_id  FROM project_building_rooms  WHERE room_id = $room_id::integer);
SET project_id = (SELECT project_id  FROM project_building  WHERE building_id = $building_id::integer);


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
    'Capteur'            as title,
    '/e_project_therm/therm_set_sensor_display_4.sql?therm_set_id='||$therm_set_id     as link;   
SELECT 
    'periode complète'            as title,
    '/e_project_therm/therm_dataset_chart_4.sql?therm_dataset_id='||$therm_dataset_id  as link;

SET date_start_min = (SELECT MIN(therm_data_date) FROM therm_data WHERE  therm_dataset_id=$therm_dataset_id::INTEGER);
SET date_end_max = (SELECT MAX(therm_data_date) FROM therm_data WHERE  therm_dataset_id=$therm_dataset_id::INTEGER);
SET hour_start_min = (SELECT MIN(therm_data_hour) FROM therm_data WHERE  therm_dataset_id=$therm_dataset_id::INTEGER AND therm_data_date=$date_start_min::DATE);
SET hour_end_max = (SELECT MAX(therm_data_hour) FROM therm_data WHERE  therm_dataset_id=$therm_dataset_id::INTEGER AND therm_data_date=$date_end_max::DATE);


SELECT 
    'form' as component,
    'Créer un jeu de donnée' as title,
    'Créer' as validate,
    'Clear' as reset,
    '/e_project_therm/therm_dataset_sample_create_0.sql?therm_dataset_id='||$therm_dataset_id  as action;

SELECT
    'date_start_min' as name,
    'text' as type,  
    'Date début des enregistrements' as label,
    3 AS width,
    $date_start_min as value,
    TRUE as readonly;

SELECT
    'hour_start_min' as name,
    'text' as type,  
    'Heure début des enregistrements' as label,
    3 AS width,
    $hour_start_min as value,
    TRUE as readonly;

 SELECT
    'date_end_max' as name,
    'text' as type,  
    'Date fin des enregistrements' as label,
    3 AS width,
    $date_end_max as value,
    TRUE as readonly;

SELECT
    'hour_end_max' as name,
    'text' as type,  
    'Heure fin des enregistrements' as label,
    3 AS width,
    $hour_end_max as value,
    TRUE as readonly;
 
SELECT
    'therm_dataset_sample_date_start'                 as name,
    'Jour début analyse'          as label,
    'select'                                as type,
    3                                      AS width,
    'Choisir une date dans la liste...'    AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label', therm_data_date, 'value', therm_data_date)) AS options
FROM (
    SELECT DISTINCT therm_data_date
    FROM therm_data 
    WHERE therm_dataset_id = $therm_dataset_id::integer
    ORDER BY therm_data_date
) AS dates;

SELECT 
    'therm_dataset_sample_hour_start' AS name,
    'Heure début analyse'       AS label,
    'select'                      AS type,
    3                            AS width,
    'Choisir une heure dans la liste...'    AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label', i.choice_label, 'value', i.choice_value) ORDER BY i.choice_value) AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='list_hours';
SELECT
    'therm_dataset_sample_date_end'                 as name,
    'Date fin analyse'          as label,
    'select'                                as type,
    3                                      AS width,
    'Choisir une date dans la liste...'    AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label', therm_data_date, 'value', therm_data_date)) AS options
FROM (
    SELECT DISTINCT therm_data_date
    FROM therm_data 
    WHERE therm_dataset_id = $therm_dataset_id::integer
    ORDER BY therm_data_date
) AS dates;

SELECT 
    'therm_dataset_sample_hour_end' AS name,
    'Heure fin analyse équence'       AS label,
    'select'                      AS type,
    3                            AS width,
    'Choisir une heure dans la liste...'    AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label', i.choice_label, 'value', i.choice_value) ORDER BY i.choice_value) AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='list_hours';