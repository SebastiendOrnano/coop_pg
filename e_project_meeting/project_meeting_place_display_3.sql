SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_3.sql') AS properties;


SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion éditeur'         AS title,
    '/a_panels/panel_editor.sql' AS link;
 SELECT 
    'Retour à la liste des projets'            AS title,
    '/e_project/project_main_display_3.sql'     AS link;   



SELECT 
    'datagrid'              AS component,
    'panel_project_meeting_place_display' AS id,
    'Gestion des lieux de réunion' AS title;

SELECT 
    '/e_project_meeting/project_meeting_place_form_3.sql'      AS link,
    'Création d''un nouveau lieu'                    AS description,
    'building-community'                             AS icon,
    'yellow'                                         AS color;
SELECT 
    '/e_project_meeting/project_meeting_map_display_3.sql'      AS link,
    'Carte des lieux de réunion'                    AS description,
    'map'                             AS icon,
    'red'                                         AS color;


-- Display list of project_meeting
SELECT 'table' AS component, 
    'Liste des salles'   AS title, 
    '/e_project_meeting/project_meeting_place_edit_3.sql?project_meeting_place_id={id}' as edit_url,
    TRUE             AS sort, 
    TRUE             AS search;

SELECT
   project_meeting_place_id         AS Id,
   project_meeting_place_id         AS _sqlpage_id,
   project_meeting_place_name        AS Nom,
   project_meeting_place_town        AS Ville
FROM project_meeting_places WHERE project_meeting_place_name IS NOT NULL AND project_meeting_place_status !='archived'
ORDER BY project_meeting_place_id ASC;
