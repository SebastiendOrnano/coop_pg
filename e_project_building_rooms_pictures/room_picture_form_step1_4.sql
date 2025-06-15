SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion Superviseur'         AS title,
    '/a_panels/panel_supervisor_4.sql' AS link;
 SELECT 
    'hub du projet'            AS title,
    '/e_project/project_hub_display_4.sql?project_id='||$project_id     AS link;  
SELECT 
    '/e_project_building_rooms/room_main_display_4.sql?building_id='||$building_id    AS link,
    'liste des lieux'  AS title;
SELECT 
    '/e_project_building_rooms_pictures/project_picture_display_4.sql?project_id='||$project_id    AS link,
    'gestion des photos du projet'  AS title;

SELECT 
    'form'   AS component,
    'choisir le batiment' AS validate,
    'clear' AS reset,
    '/e_project_building_rooms_pictures/room_picture_create_step1_0.sql?project_id='||$project_id AS action;

SELECT 
    'building_id' AS name,
    'Choisir le bâtiment' AS label,
    'select' AS type,
    12 AS width,
    TRUE AS searchable,
   'Saisissez quelques lettres du titre que vous cherchez ou choississez dans la liste' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',building_name,'value', building_id))  AS options
    FROM project_building
    WHERE project_id=$project_id::INTEGER;

