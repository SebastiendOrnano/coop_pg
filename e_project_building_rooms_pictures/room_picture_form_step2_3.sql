SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_3.sql') AS properties;


SET project_id = SELECT project_id from project_building where building_id=$building_id::INTEGER;



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
SELECT 
    '/e_project_building_rooms_pictures/project_picture_display_3.sql?project_id='||$project_id    AS link,
    'gestion des photos du projet'  AS title;

SELECT 
    'form'   AS component,
    '' AS validate;
SELECT
    'building_id' AS name,
    TRUE AS readonly,
    'Id ' AS label,
    1 AS width,
     $building_id AS value;
SELECT
    'building_name' AS name,
    TRUE AS readonly,
    'Nom du Bâtiment' AS label,
    5 AS width,
    (SELECT building_name  FROM project_building WHERE building_id = $building_id::INTEGER ) AS value;


SELECT 
    'form'   AS component,
    'choisir la pièce' AS validate,
    'clear' AS reset,
    '/e_project_building_rooms_pictures/room_picture_create_step2_0.sql?building_id='||$building_id  AS action;
SELECT 
    'room_id' AS name,
    'choisir la pièce dans le bâtiment' AS label,
    'select' AS type,
    12 AS width,
    TRUE AS searchable,
   'Saisissez quelques lettres du titre que vous cherchez ou choississez dans la liste' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',room_name,'value', room_id))  AS options
    FROM project_building_rooms
    WHERE building_id=$building_id::INTEGER;
