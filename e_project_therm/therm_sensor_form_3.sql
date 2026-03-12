SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_3.sql') AS properties;

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
    'form' as component,
    'Créer une sonde' as title,
    'Créer' as validate,
    'Clear' as reset,
    '/e_project_therm/therm_sensor_create_0.sql'  as action;

SELECT
    'therm_sensor_name' as name,
    'text' as type,  
    'Nom' as label,
    12 AS width,
    TRUE as required;

SELECT
    'therm_sensor_manufacturer' as name,
    'text' as type,
    'Fabricant' as description,
    'Fabricant' as label,
    4 as width;

SELECT
    'therm_sensor_model' as name,
    'text' as type,  
    'Modèle' as label,
    4 as width;

SELECT
    'therm_sensor_serie_no' as name,
    'text' as type,  
    'N° série' as label,
    4 as width;

SELECT
    'therm_sensor_specifications' as name,
    'textarea' as type,
    'Spécifications...' as description,
    'Spécifications' as label;


