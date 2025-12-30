SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SET project_id = SELECT project_id FROM project_building WHERE building_id=$building_id::INTEGER;


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
    'Hub du projet'            as title,
    '/e_project/project_hub_display_4.sql?project_id='||$project_id     as link;   
 SELECT 
    'Bâtiments actifs'            as title,
    '/e_project_building/building_main_display_4.sql?project_id='||$project_id     as link;   



SELECT 
    'divider' as component,
    'Nom du bâtiment de rattachement'    as contents,
    'blue' as color;

SELECT 
    'form'   as component,
    '' as validate;

SELECT
    'building_id' as name,
    TRUE as readonly,
    'Id ' as label,
    1 as width,
   $building_id as value;

SELECT
    'building_name' as name,
    TRUE as readonly,
    'Nom du lieu de rattachement' as label,
    6 as width,
    (SELECT building_name  FROM project_building WHERE building_id = $building_id::INTEGER ) as value;
 
SELECT 
    'divider' as component,
    'Liste des pièces ou des salles rattachées au lieu'    as contents,
    'blue' as color;

SELECT 
    'table'               AS component, 
    'Liste des pièces ou des salles rattachées au lieu' AS title, 
    TRUE                  AS sort, 
    JSON('{"name":"Pict","tooltip":"Voir les photos de la pièce","link":"/e_project_building_rooms_pictures/room_picture_display_4.sql?room_id={id}","icon":"camera"}') as custom_actions,
    '/e_project_building_rooms/room_main_edit_4.sql?room_id={id}' as edit_url,
    '/e_project_building_rooms/room_main_delete_alert_4.sql?room_id={id}' as delete_url,
    FALSE                 AS search;

SELECT
    room_id            AS Id,
    room_id            AS _sqlpage_id,
    room_name            AS Nom,
    room_type             as Type
FROM project_building_rooms
WHERE building_id = $building_id::INTEGER and room_status='archived'
ORDER BY room_id ASC;


