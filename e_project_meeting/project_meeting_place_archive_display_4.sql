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
    'Retour à la liste des projets'            AS title,
    '/e_project/project_main_display_4.sql'     AS link;
SELECT 
    'Retour à la liste des salles actives'            AS title,
    '/e_project_meeting/project_meeting_place_display_4.sql'     AS link; 

SELECT 
    'divider' AS component,
    'Liste des salles archivées'   AS contents;


-- Display list of placenizations
SELECT 'table' AS component, 
    'Liste des salles'   AS title, 
    'View'           AS markdown,
    TRUE             AS sort, 
    TRUE             AS search;

SELECT
   project_meeting_place_id         AS Id,
   project_meeting_place_name        AS Nom,
   project_meeting_place_town        AS Ville,
   '[Edit](/e_project_meeting/project_meeting_place_edit_4.sql?project_meeting_place_id=' || project_meeting_place_id || ')&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Delete](/e_project_meeting/project_meeting_place_delete_alert1_4.sql?project_meeting_place_id=' || project_meeting_place_id|| ')'    AS View
FROM project_meeting_places WHERE project_meeting_place_name IS NOT NULL AND project_meeting_place_status ='archived'
ORDER BY project_meeting_place_id ASC;
