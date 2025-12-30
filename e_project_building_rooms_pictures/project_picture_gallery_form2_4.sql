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
    '/e_project_building_rooms_pictures/project_picture_gallery_4.sql?project_id='||$project_id    AS link,
    'galerie des photos du projet'  AS title;

SELECT 
    'form'   AS component,
    'choisir le batiment et le lot de travaux' AS validate,
    'clear' AS reset,
    '/e_project_building_rooms_pictures/project_picture_gallery_workpackage_4.sql?project_id='||$project_id AS action;
SELECT 
    'workpackage_id' AS name,
    'choisir le lot de travaux' AS label,
    'select' AS type,
    6 AS width,
    TRUE AS searchable,
   'Saisissez quelques lettres du titre que vous cherchez ou choississez dans la liste' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',workpackage_name,'value', workpackage_id))  AS options
    FROM project_workpackage
    WHERE project_id=$project_id::INTEGER;

