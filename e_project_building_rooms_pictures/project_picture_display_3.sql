SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_3.sql') AS properties;


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
select 
    '/e_project_building/building_main_display_3.sql?project_id='||$project_id    as link,
    'liste des lieux'  as title; 

SELECT 
    'datagrid'              AS component,
    'panel_project_display' AS id,
    'Liste des images rattachées au lieu'   AS title;
SELECT 
 '/e_project_building_rooms_pictures/room_picture_form_step1_3.sql?project_id='||$project_id   AS link,
    'Ajouter une nouvelle image ou plan'                  AS description,
    'photo-scan'                                      AS icon,
    'yellow'                                         AS color;

SELECT 
    'table'               AS component, 
    'Liste des images rattachées au lieu' AS title, 
    TRUE                  AS sort,
    'Img'                  AS markdown, 
    'View'                AS markdown, 
    FALSE                 AS search;

SELECT
    '![view picture]('||p.room_picture_url||')'   AS Img,
    p.room_picture_id                             AS Id,
    p.room_picture_title                          AS Nom,
    p.room_picture_format                         AS Format,
    r.room_name                                   AS Piece,
    b.building_name                               AS Batiment,
'[View]('||p.room_picture_url||')&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
[Edit](/e_project_building_rooms_pictures/room_picture_edit_3.sql?room_picture_id='||p.room_picture_id||')'    AS View
FROM project_building_rooms_pictures AS p
LEFT JOIN (SELECT room_id, room_name, building_id FROM project_building_rooms) AS r
on p.room_id = r.room_id
LEFT JOIN (SELECT building_id, building_name, project_id FROM project_building) AS b
on r.building_id = b.building_id
WHERE b.project_id = $project_id::INTEGER AND  p.room_picture_status ='active'
ORDER BY p.room_picture_id ASC;


