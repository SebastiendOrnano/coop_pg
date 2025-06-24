SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_3.sql') AS properties;

SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion éditeur'         AS title,
    '/a_panels/panel_editor_3.sql' AS link;
 SELECT 
    'Retour au hub du projet'            AS title,
    '/e_project/project_hub_display_3.sql?project_id='||$project_id     AS link;  
SELECT 
    '/e_project_building_rooms/room_main_display_3.sql?building_id='||$building_id    AS link,
    'Retour à la liste des lieux'  AS title;
SELECT 
    '/e_project_building_rooms_pictures/project_picture_display_3.sql?project_id='||$project_id    AS link,
    'gestion des photos du projet'  AS title;

SELECT 
    'form'   AS component,
    'choisir la photo' AS validate,
    'clear' AS reset,
    '/e_project_building_rooms_pictures/room_picture_view_3.sql?room_picture_id='||:room_picture_id  AS action;
SELECT 
    'room_picture_id' AS name,
    'chercher par le nom de la photo' AS label,
    'select' AS type,
    6 AS width,
    TRUE AS searchable,
   'Saisissez quelques lettres du titre que vous cherchez ou choississez dans la liste' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',room_picture_title,'value', room_picture_id)ORDER BY room_picture_id ASC)  AS options
    FROM project_building_rooms_pictures
    WHERE project_id=$project_id::INTEGER;

