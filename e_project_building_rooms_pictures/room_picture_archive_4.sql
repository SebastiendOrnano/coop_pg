SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;


SET building_id = SELECT building_id FROM project_building_rooms WHERE room_id=$room_id::INTEGER;
SET building_name= SELECT building_name FROM project_building WHERE building_id=$building_id::INTEGER;
SET project_id = SELECT project_id FROM project_building WHERE building_id=$building_id::INTEGER;

SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion Superviseur'         AS title,
    '/a_panels/panel_supervisor_4.sql' AS link;
 SELECT 
    'Hub du projet'            AS title,
    '/e_project/project_hub_display_4.sql?project_id='||$project_id     AS link;  
SELECT 
    '/e_project_building_rooms/room_main_display_4.sql?building_id='||$building_id    AS link,
    'Liste des lieux'  AS title;
SELECT 
    '/e_project_building_rooms_pictures/room_picture_display_4.sql?room_id='||$room_id    AS link,
    'Photos actives'  AS title;


SELECT 
    'divider' AS component,
    'Nom du bâtiment'    AS contents,
    'blue' AS color;
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
    'room_id' AS name,
    TRUE AS readonly,
    'Id ' AS label,
    1 AS width,
    $room_id AS value;
SELECT
    'room_name' AS name,
    TRUE AS readonly,
    'Nom de la pièce' AS label,
    5 AS width,
    (SELECT room_name  FROM project_building_rooms WHERE room_id = $room_id::INTEGER ) AS value;
 
SELECT 
    'divider' AS component,
    'images rattachées au lieu'    AS contents,
    'blue' AS color;


SELECT 
    'table'               AS component, 
    'Liste des images rattachées au lieu' AS title, 
    TRUE                  AS sort,
    'Img'                  AS markdown, 
    'View'                AS markdown, 
    FALSE                 AS search;

SELECT
      '![view picture]('||room_picture_url||')' AS Img,
    room_picture_id            AS Id,
    room_picture_title            AS Nom,
    room_picture_format            AS Format,
'[View]('||room_picture_url||')&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
[Edit](/e_project_building_rooms_pictures/room_picture_edit_4.sql?room_picture_id=' 
||room_picture_id|| 
') &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [Delete](/e_project_building_rooms_pictures/room_picture_delete_alert_4.sql?room_picture_id=' 
||room_picture_id||
')'    AS View
FROM project_building_rooms_pictures
WHERE room_id = $room_id::INTEGER and room_picture_status!='active'
ORDER BY room_picture_id ASC;


