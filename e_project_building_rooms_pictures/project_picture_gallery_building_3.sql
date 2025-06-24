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
 

SET building_name = SELECT building_name FROM project_building where  building_id = :building_id::INTEGER;

SELECT
    'text'              as component,
    '  

**Galerie des photos d''un bâtiment du  projet :** ' ||$building_name as contents_md;

SELECT 
    'datagrid'              AS component,
    'Galerie des photos d''un bâtiment du  projet '        AS title;
SELECT 
    p.room_picture_title                     AS title,
    p.room_picture_url                       AS link,
    p.room_picture_url                       AS image_url,
    b.building_name ||'---'|| r.room_name||'---'|| w.workpackage_name||'---'|| s.worksequence_name    AS footer
    FROM project_building_rooms_pictures     AS p
    LEFT JOIN (SELECT room_id, room_name, building_id FROM project_building_rooms) AS r
    on p.room_id = r.room_id
    LEFT JOIN (SELECT workpackage_id, workpackage_name FROM project_workpackage) AS w
    on p.workpackage_id = w.workpackage_id
    LEFT JOIN (SELECT worksequence_id, worksequence_name FROM project_worksequence) AS s
    on p.worksequence_id = s.worksequence_id
    LEFT JOIN (SELECT building_id, building_name, project_id FROM project_building) AS b
    on r.building_id = b.building_id
    WHERE b.project_id = $project_id::INTEGER and b.building_id = :building_id::INTEGER
    ORDER BY p.room_picture_id ASC;


