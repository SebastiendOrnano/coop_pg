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
    'liste des projets'            as title,
    '/e_project/project_main_display_4.sql'     as link;   
 SELECT 
    'hub du projet'            as title,
    '/e_project/project_hub_display_4.sql?project_id='||$project_id     as link;   
 SELECT 
    'Therm'            as title,
    '/e_project_therm/therm_set_display_4.sql?project_id='||$project_id     as link;    


SELECT 
    'form' as component,
    'Créer une campagne de mesure' as title,
    'Créer' as validate,
    'Clear' as reset,
    '/e_project_therm/therm_set_create_0.sql?project_id='||$project_id as action;

SELECT
    'therm_set_name' as name,
    'text' as type,  
    'Nom de la campagne de mesure' as label,
    6 AS width,
    TRUE as required;

SELECT 
    'room_id' AS name,
    'lieu des mesure' AS label,
    'select' AS type,
    6 AS width,
    TRUE AS searchable
    TRUE as required,
   'Saisissez quelques lettres du titre que vous cherchez ou choississez dans la liste' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',b.building_name||' -- '||r.room_name||' -- '||r.room_type , 'value', r.room_id))  AS options
    FROM project_building_rooms AS r
    LEFT JOIN (SELECT building_id, building_name, project_id FROM project_building)  AS b 
    ON r.building_id = b.building_id
    WHERE b.project_id=$project_id::INTEGER

SELECT
    'therm_set_description' as name,
    'textarea' as type,
    'Objectifs de la campagne de mesure' as label;
