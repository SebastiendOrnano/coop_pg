SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_3.sql') AS properties;

select 
    'breadcrumb' as component;
select 
    'Home' as title,
    '/'    as link;
select 
    'Gestion éditeur'         as title,
    '/a_panels/panel_editor_3.sql' as link;
 select 
    'hub du projet'            as title,
    '/e_project/project_hub_display_3.sql?project_id='||$project_id     as link;  
select 
    '/e_project_building/building_main_display_3.sql?project_id='||$project_id    as link,
    'liste des lieux'  as title;
SELECT 
    '/e_project_building_rooms_pictures/project_picture_display_3.sql?project_id='||$project_id    AS link,
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

