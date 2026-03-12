SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_3.sql') AS properties;

SET therm_set_sensor_id = SELECT therm_set_sensor_id FROM therm_dataset WHERE therm_dataset_id=$therm_dataset_id::INTEGER;
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
    'form' as component,

    '' as validate;
SELECT
    'therm_set_description' as name,
    'text' as type,  
    'Rappel des objectifs et du contexte de la campagne de mesure' as label,
    true as readonly,
    (SELECT therm_set_description FROM therm_set WHERE therm_set_id=$therm_set_id::INTEGER) as value;
SELECT
    'therm_sensor_name' as name,
    'text' as type,  
    'Capteur' as label,
    true as readonly,
    6 as width,
    (SELECT therm_sensor_name FROM therm_sensor as s
    LEFT JOIN (SELECT therm_sensor_id, therm_set_sensor_id, therm_set_id FROM therm_set_sensor) as d
    ON d.therm_sensor_id = s.therm_sensor_id
    LEFT JOIN (SELECT therm_set_sensor_id, therm_dataset_id FROM therm_dataset) as t
    ON t.therm_set_sensor_id = d.therm_set_sensor_id
    WHERE therm_dataset_id=$therm_dataset_id::INTEGER) as value;

SELECT
    'therm_dataset_name' as name,
    'text' as type,  
    'Dataset' as label,
    true as readonly,
    6 as width,
    (SELECT therm_dataset_name FROM therm_dataset WHERE therm_dataset_id=$therm_dataset_id::INTEGER) as value;



SELECT 
    'table'               AS component, 
    'Liste des jeux de données' AS title, 
    TRUE                  AS sort,
    '/e_project_therm/therm_data_edit_3.sql?therm_data_id={id}' as edit_url,
    FALSE                 AS search;

SELECT
    s.therm_dataset_name                             AS Dataset,
    d.therm_data_id                                  AS Id,
    d.therm_data_id                                  AS _sqlpage_id,
    d.therm_data_date                                AS Date,
    d.therm_data_hour                                AS Heure,
    d.therm_data_temp                                AS Temp,
    d.therm_data_rh                                  AS RH,
    d.therm_data_co2                                 AS CO2
FROM therm_data AS d
LEFT JOIN (SELECT therm_dataset_id, therm_dataset_name FROM therm_dataset) AS s 
ON s.therm_dataset_id=d.therm_dataset_id
WHERE d.therm_dataset_id=$therm_dataset_id::INTEGER
ORDER BY d.therm_dataset_id ;


