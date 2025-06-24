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
    'Images du projet'            AS title,
    '/e_project_building_rooms_pictures/project_picture_gallery_3.sql?project_id='||$project_id AS link  
 

SELECT 
    'datagrid'              AS component,
    'Galerie des photos du projet  :'||$project_name        AS title;
SELECT 
    p.room_picture_title                     AS title,
  '/e_project_building_rooms_pictures/room_picture_view_4.sql?room_picture_id='||p.room_picture_id  AS link,
    p.room_picture_url                       AS image_url,
    b.building_name ||'---'|| r.room_name    AS footer
    FROM project_building_rooms_pictures     AS p
    LEFT JOIN (SELECT room_id, room_name, building_id FROM project_building_rooms) AS r
    on p.room_id = r.room_id
    LEFT JOIN (SELECT building_id, building_name, project_id FROM project_building) AS b
    on r.building_id = b.building_id
    WHERE b.project_id = $project_id::INTEGER AND workpackage_id=:workpackage_id::INTEGER
    ORDER BY p.room_picture_id ASC;


