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
    'Retour au hub du projet'            AS title,
    '/e_project/project_hub_display_4.sql?project_id='||$project_id     AS link;
select 
    '/e_project_building/building_main_display_4.sql?project_id='||$project_id    as link,
    'liste des lieux'  as title; 



SELECT 
    'datagrid'              AS component,
    'panel_project_display' AS id,
    'Liste des images rattachées au lieu'   AS title;
SELECT 
 '/e_project_building_rooms_pictures/room_picture_form_step1_4.sql?project_id='||$project_id   AS link,
    'Ajouter une nouvelle image ou plan'                  AS description,
    'photo-scan'                                      AS icon,
    'yellow'                                         AS color;

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
    '![view picture]('||p.room_picture_url||')'   AS Img,
    p.room_picture_id                             AS Id,
    p.room_picture_id                             AS _sqlpage_id,
    p.room_picture_title                          AS Nom,
    b.building_name                               AS Batiment,
    r.room_name                                   AS Piece,
    w.workpackage_name                           AS LotTravaux,
    s.worksequence_name                           AS SeqChantier
FROM project_building_rooms_pictures AS p
LEFT JOIN (SELECT room_id, room_name, building_id FROM project_building_rooms) AS r
on p.room_id = r.room_id
LEFT JOIN (SELECT building_id, building_name, project_id FROM project_building) AS b
on r.building_id = b.building_id
LEFT JOIN (select  workpackage_id, workpackage_name FROM project_workpackage) as w 
ON p.workpackage_id=w.workpackage_id
LEFT JOIN (select  worksequence_id, worksequence_name FROM project_worksequence) as s 
ON p.worksequence_id=s.worksequence_id
WHERE b.project_id = $project_id::INTEGER AND  p.room_picture_status ='active'
ORDER BY p.room_picture_id ASC;


