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
    'Hub du projet'            AS title,
    '/e_project/project_hub_display_4.sql?project_id='||$project_id     AS link;
 SELECT 
    'Images du projet'            AS title,
    '/e_project_building_rooms_pictures/project_picture_gallery_4.sql?project_id='||$project_id AS link
 
SELECT 
    'datagrid'              AS component,
    'Galerie des photos du projet  :'||$project_name        AS title;
SELECT 
    p.room_picture_title                     AS title,
    p.room_picture_url                       AS link,
    p.room_picture_url                       AS image_url,
    b.building_name ||'---'|| r.room_name    AS footer
    FROM project_building_rooms_pictures     AS p
    LEFT JOIN (SELECT room_id, room_name, building_id FROM project_building_rooms) AS r
    on p.room_id = r.room_id
    LEFT JOIN (SELECT building_id, building_name, project_id FROM project_building) AS b
    on r.building_id = b.building_id
    WHERE b.project_id = $project_id::INTEGER AND room_picture_id =:room_picture_id::INTEGER
    ORDER BY p.room_picture_id ASC;


