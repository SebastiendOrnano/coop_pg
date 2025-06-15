SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_3.sql') AS properties;


SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion editeur'         AS title,
    '/a_panels/panel_editor_3.sql' AS link;
 SELECT 
    'Projets'            AS title,
    '/e_project/project_main_display_3.sql'     AS link;   
 SELECT 
    'Hub du projet'            AS title,
    '/e_project/project_hub_display_3.sql?project_id='||$project_id     AS link;   

SELECT 
    'datagrid'              AS component,
    'panel_building_display' AS id,
    'Gestion des bâtiments' AS title;
SELECT 
    '/e_project_building/building_main_form_3.sql?project_id='||$project_id     AS link,
    'Création d''un nouveau lieu'                  AS description,
    'building-community'                                      AS icon,
    'yellow'                                         AS color;



-- Display list of places
SELECT 'table' AS component, 
    'Liste des salles'   AS title, 
    'View'           AS markdown,
    TRUE             AS sort, 
    TRUE             AS search;

SELECT
    building_id         AS Id,
   building_name        AS Nom,
   building_town        AS Ville,
   '[Map](/e_project_building/building_map_display_3.sql?building_id='||building_id||')&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
   [view](/e_project_building/building_main_profile_3.sql?building_id='||building_id||')&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
   [rooms](/e_project_building_rooms/room_main_display_3.sql?building_id='|| building_id|| ')&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
   [Edit](/e_project_building/building_main_edit_3.sql?building_id=' || building_id ||')'    AS View
FROM project_building 
WHERE project_id = $project_id::INTEGER 
AND building_status !='archived' 
ORDER BY building_id ASC;
