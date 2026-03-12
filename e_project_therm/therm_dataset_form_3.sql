SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_3.sql') AS properties;

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
    'Projets'            as title,
    '/e_project/project_main_display_3.sql'     as link;   
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
    'Dataset'            as title,
    '/e_project_therm/therm_dataset_display_3.sql?therm_set_sensor_id='||$therm_set_sensor_id    as link;  


SELECT 
    'form' as component,
    'Créer un jeu de donnée' as title,
    'Créer' as validate,
    'Clear' as reset,
    '/e_project_therm/therm_dataset_create_0.sql?therm_set_sensor_id='||$therm_set_sensor_id  as action;

SELECT
    'therm_dataset_name' as name,
    'text' as type,  
    'Nom du jeu de données' as label,
    12 AS width,
    TRUE as required;



