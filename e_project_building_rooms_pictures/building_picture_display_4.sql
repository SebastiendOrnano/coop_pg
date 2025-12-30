SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;



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
    'Pièces du bâtiment'  AS title;

SELECT 
    'datagrid'              AS component;
SELECT 
    '/e_project_building_rooms_pictures/room_picture_form_4.sql?room_id='||$room_id     AS link,
    'Créer une nouvelle image ou plan'                           AS description,
    'photo-search'                                               AS icon,
    'yellow'                                                     AS color;
SELECT 
    '/e_project_building_rooms_pictures/room_picture_archive_4.sql?room_id='||$room_id     AS link,
    'Images archivées'                           AS description,
    'archive'                                               AS icon,
    'green'                                                     AS color;


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
    'divider' AS component,
    'images rattachées au lieu'    AS contents,
    'blue' AS color;

SELECT 
    'table'               AS component, 
    'Liste des images rattachées au lieu' AS title, 
    TRUE                  AS sort,
    'Img'                  AS markdown, 
    JSON('{"name":"View","tooltip":"Voir le profil","link":"/e_project_building_rooms_pictures/room_picture_view_4.sql?room_picture_id={id}","icon":"user-scan"}') as custom_actions,
    '/e_project_building_rooms_pictures/room_picture_edit_4.sql?room_picture_id={id}' as edit_url,
    '/e_project_building_rooms_pictures/room_picture_delete_alert_4.sql?room_picture_id={id}' as delete_url,
    FALSE                 AS search;

SELECT
    '![room_picture_url]('||p.room_picture_url||')' AS Img,
    p.room_picture_id            AS Id,
    p.room_picture_id                             AS _sqlpage_id,
    p.room_picture_title            AS Nom,
    r.room_name                     AS Piece
FROM project_building_rooms_pictures as p 
LEFT JOIN (select room_id, room_name FROM project_building_rooms) as r 
ON p.room_id = r.room_id
WHERE p.building_id = $building_id::INTEGER AND p.room_picture_status = 'active'
ORDER BY p.room_picture_id ASC;


