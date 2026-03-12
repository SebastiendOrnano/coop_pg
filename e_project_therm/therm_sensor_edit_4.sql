SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

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
    'Sensor'            as title,
    '/e_project_therm/therm_sensor_display_4.sql'   as link;  

SELECT 
    'form' as component,
    'Actualiser une sonde' as title,
    'Actualiser' as validate,
    'Clear' as reset,
    '/e_project_therm/therm_sensor_update_0.sql?therm_sensor_id='||$therm_sensor_id as action;

SELECT
    'therm_sensor_name' as name,
    'text' as type,  
    'Nom Commercial' as label,
    9 AS width,
    (SELECT therm_sensor_name FROM therm_sensor WHERE therm_sensor_id=$therm_sensor_id::INTEGER) as value,
    TRUE as required;

SELECT
    'therm_sensor_status'    AS name,
    'Statut'                 AS label,
    'select'                 AS type,
    3 AS width,
    TRUE                     AS required,
    (SELECT therm_sensor_status  FROM therm_sensor WHERE therm_sensor_id=$therm_sensor_id::INTEGER) as value,
    'choisir unstatut dans la liste...'    AS  empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='status';


SELECT
    'therm_sensor_manufacturer' as name,
    'text' as type,
    'Fabricant' as description,
    (SELECT therm_sensor_manufacturer FROM therm_sensor WHERE therm_sensor_id=$therm_sensor_id::INTEGER) as value,
    'Fabricant' as label,
    4 as width;

SELECT
    'therm_sensor_model' as name,
    'text' as type,  
    'Modèle' as label,
    (SELECT therm_sensor_model FROM therm_sensor WHERE therm_sensor_id=$therm_sensor_id::INTEGER) as value,
    4 as width;

SELECT
    'therm_sensor_serie_no' as name,
    'text' as type,  
    'N° série' as label,
    (SELECT therm_sensor_serie_no FROM therm_sensor WHERE therm_sensor_id=$therm_sensor_id::INTEGER) as value,
    4 as width;
    
SELECT
    'therm_sensor_specifications' as name,
    'textarea' as type,
    'Spécifications...' as description,
    (SELECT therm_sensor_specifications FROM therm_sensor WHERE therm_sensor_id=$therm_sensor_id::INTEGER) as value,
    'Spécifications' as label;


