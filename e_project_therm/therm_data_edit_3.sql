SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_3.sql') AS properties;

SET therm_dataset_id= SELECT therm_dataset_id FROM therm_data WHERE therm_data_id =$therm_data_id::INTEGER;
SET therm_set_sensor_id = SELECT therm_set_sensor_id FROM therm_dataset WHERE therm_dataset_id = $therm_dataset_id::integer
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
    'Gestion Editeur'         as title,
    '/a_panels/panel_editor_3.sql' as link;
 SELECT 
    'liste des projets'            as title,
    '/e_project/project_main_display_3.sql'     as link;   
 SELECT 
    'hub du projet'            as title,
    '/e_project/project_hub_display_3.sql?project_id='||$project_id     as link;   
 SELECT 
    'Therm'            as title,
    '/e_project_therm/therm_set_display_3.sql?project_id='||$project_id     as link;   
 SELECT 
    'Capteur'            as title,
    '/e_project_therm/therm_set_sensor_display_3.sql?therm_set_id='||$therm_set_id     as link;   
 SELECT 
    'Dataset'            as title,
    '/e_project_therm/therm_dataset_display_3.sql?therm_set_sensor_id='||$therm_set_sensor_id   as link;
SELECT 
    'Data'            as title,
    '/e_project_therm/therm_data_display_3.sql?therm_dataset_id='||$therm_dataset_id::INTEGER as link;



SELECT 
    'form' as component,
    'Actualiser des données' as title,
    'Actualiser' as validate,
    'Clear' as reset,
    '/e_project_therm/therm_data_update_0.sql?therm_data_id='||$therm_data_id as action;

SELECT
    'therm_data_temp' as name,
    'text' as type,  
    'Tempéature' as label,
    (SELECT therm_data_temp FROM therm_data WHERE therm_data_id=$therm_data_id::INTEGER) AS value,
    4 AS width;

SELECT
    'therm_data_rh' as name,
    'text' as type,
    'Humidité' as label,
    (SELECT therm_data_rh FROM therm_data WHERE therm_data_id=$therm_data_id::INTEGER) AS value,
    4 as width;

SELECT
    'therm_data_co2' as name,
    'text' as type,  
    'CO2' as label,
    (SELECT therm_data_co2 FROM therm_data WHERE therm_data_id=$therm_data_id::INTEGER) AS value,
    4 as width;

SELECT
    'therm_data_date' as name,
    'date'                              AS type,
    'Date de la mesure'                 AS label,
    4                                   AS width,
    TRUE                                AS required,
    (SELECT therm_data_date FROM therm_data WHERE therm_data_id=$therm_data_id::INTEGER) AS value,
   (SELECT regex_value FROM regex WHERE regex_name='date')                AS pattern,
   (SELECT regex_description FROM regex WHERE regex_name='date')          AS description;

SELECT
    'therm_data_hour' as name,
    'Heure mesure'       AS label,
    'text'                      AS type,
    4                            AS width,
    (SELECT therm_data_hour FROM therm_data WHERE therm_data_id=$therm_data_id::INTEGER) AS value;


