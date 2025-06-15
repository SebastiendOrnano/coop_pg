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

-- Display list of placenizations
SELECT 'table' AS component, 
    'Liste des salles'   AS title, 
    'View'           AS markdown,
    TRUE             AS sort, 
    TRUE             AS search;

SELECT
    building_id         AS Id,
   building_name        AS Nom,
   building_town        AS Ville,
   '[room](/e_building_rooms/room_main_display_4.sql?building_id=' || building_id || ')&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
   [Edit](/e_project_building/building_main_edit_4.sql?building_id=' || building_id || ')&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
   [Delete](/e_project_building/building_main_delete_alert_4.sql?building_id=' || building_id|| ')'    AS View
FROM project_building WHERE building_name IS NOT NULL AND building_status='archived'
ORDER BY building_id ASC;
