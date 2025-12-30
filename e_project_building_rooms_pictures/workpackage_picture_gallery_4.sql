SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SET building_id          = SELECT building_id  FROM project_building WHERE project_id =$project_id::INTEGER 
SET room_id              = SELECT room_id FROM project_building_rooms WHERE building_id=$building_id::INTEGER;
SET room_picture_id      = SELECT room_picture_id FROM project_building_rooms_pictures WHERE room_id=$room_id::INTEGER;;
SET project_name         =   (SELECT project_name  FROM project WHERE project_id = $project_id::INTEGER);


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
    '/e_project/project_hub_display_4.sql?project_id='||$project_id      AS link;
 SELECT 
    'Hub du lot de travaux'            AS title,
    '/e_project_workpackage/workpackage_hub_display_4.sql?workpackage_id='||$workpackage_id    AS link; 
 

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
    WHERE b.project_id = $project_id
    ORDER BY p.room_picture_id ASC;


