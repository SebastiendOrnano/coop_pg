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
    '/e_project_therm/therm_dataset_display_4.sql?therm_set_sensor_id='||$therm_set_sensor_id    as link;  




SELECT 
    'form' as component,
    'Actualiser un jeu de donnée' as title,
    'Créer' as validate,
    'Clear' as reset,
    '/e_project_therm/therm_dataset_update_0.sql?therm_dataset_id='||$therm_dataset_id  as action;

SELECT
    'therm_dataset_name' as name,
    'text' as type,  
    'Nom du jeu de données' as label,
    (SELECT therm_dataset_name FROM therm_dataset WHERE therm_dataset_id=$therm_dataset_id::INTEGER) as value,
    12 AS width,
    TRUE as required;

SELECT 
    'therm_dataset_status'            as name,
    'Statut'                 as label,
    'select'                 as type,
    3 as width,
    TRUE                     as required,
    (SELECT therm_dataset_status  FROM therm_dataset WHERE therm_dataset_id = $therm_dataset_id::INTEGER ) as value,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='status';




