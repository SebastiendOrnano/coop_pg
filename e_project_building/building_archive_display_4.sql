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
    'Liste des projets'            AS title,
    '/e_project/project_main_display_4.sql'     AS link;   
 SELECT 
    'Hub du projet'            AS title,
    '/e_project/project_hub_display_4.sql?project_id='||$project_id     AS link;   
 SELECT 
    'Bâtiments actifs du projet'            AS title,
    '/e_project_building/building_main_display_4.sql?project_id='||$project_id      AS link;

-- Display list of places
SELECT 'table' AS component, 
    'Liste des salles'   AS title, 
 JSON('{"name":"Map","tooltip":"Localiser le bâtiment","link":"/e_project_building/building_map_display_4.sql?building_id={id}","icon":"map-pin-check"}') as custom_actions,
    JSON('{"name":"View","tooltip":"Voir le bâtiment","link":"/e_project_building/building_main_profile_4.sql?building_id={id}","icon":"building"}') as custom_actions,
    JSON('{"name":"Room","tooltip":"Voir les pièces du bâtiment","link":"/e_project_building_rooms/room_main_display_4.sql?building_id={id}","icon":"layout-dashboard"}') as custom_actions,
    '/e_project_building/building_main_edit_4.sql?building_id={id}' as edit_url,
    '/e_project_building/building_main_delete_alert_4.sql?building_id={id}' as delete_url,
    TRUE             AS sort, 
    TRUE             AS search;

SELECT
    building_id         AS Id,
    building_id         AS _sqlpage_id,
   building_name        AS Nom,
   building_town        AS Ville
FROM project_building 
FROM project_building WHERE project_id = $project_id::INTEGER AND building_name IS NOT NULL AND building_status='archived'
ORDER BY building_id ASC;
