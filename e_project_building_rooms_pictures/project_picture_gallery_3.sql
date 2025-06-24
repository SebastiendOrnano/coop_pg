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
    'datagrid'              AS component;
SELECT 
    '/e_project_building_rooms_pictures/project_picture_gallery_form1_3.sql?project_id='||$project_id     AS link,
    'Chercher une image par bâtiment'                            AS description,
    'photo-search'                                               AS icon,
    'yellow'                                                     AS color;
SELECT 
    '/e_project_building_rooms_pictures/project_picture_gallery_form2_3.sql?project_id='||$project_id     AS link,
    'Chercher une image par lot de travaux'                      AS description,
    'photo-search'                                               AS icon,
    'green'                                                      AS color;
SELECT 
    '/e_project_building_rooms_pictures/project_picture_gallery_form3_3.sql?project_id='||$project_id     AS link,
    'Chercher une image par son nom'                             AS description,
    'photo-search'                                               AS icon,
    'yellow'                                                      AS color;


SELECT 
    'divider' as component,
    'left'    as position,
    'blue'   as color,
    3         as size,
    'Galerie de toutes les photos du projet'       AS contents;



SELECT 
    'datagrid'              AS component,
    'Galerie des photos du projet  :'||$project_name        AS title;
SELECT 
    p.room_picture_title                                                         AS title,
    '/e_project_building_rooms_pictures/room_picture_view_3.sql?room_picture_id='||p.room_picture_id  AS link,
    p.room_picture_url                                                           AS image_url
    FROM project_building_rooms_pictures     AS p
    LEFT JOIN (SELECT room_id, room_name, building_id FROM project_building_rooms) AS r
    on p.room_id = r.room_id
    LEFT JOIN (SELECT building_id, building_name, project_id FROM project_building) AS b
    on r.building_id = b.building_id
    WHERE b.project_id = $project_id::INTEGER
    ORDER BY p.room_picture_id ASC;


