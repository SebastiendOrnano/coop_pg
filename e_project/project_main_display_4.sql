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
    'datagrid'              AS component,
    'panel_project_display' AS id,
    'Gestion des projets'   AS title;
SELECT 
    '/e_project/project_main_form_4.sql'             AS link,
    'Création d''un nouveau projet'                   AS description,
    'chart-dots-2'                                      AS icon,
    'yellow'                                         AS color;
SELECT 
    '/e_project/project_map_private_display_4.sql'         AS link,
    'Carte des projets '                  AS description,
    'pin'                                              AS icon,
    'red'                                             AS color;
SELECT 
    '/e_project/project_archive_display_4.sql'             AS link,
    'Visualiser les projets achivés'                       AS description,
    'archive'                                              AS icon,
    'green'                                                AS color;
SELECT 
    '/e_project_meeting/project_meeting_place_display_4.sql'         AS link,
    'Gestion des lieux de réunion'                  AS description,
    'map-search'                                              AS icon,
    'blue'                                             AS color;

SELECT 
    '/e_project_products/product_main_display_4.sql'         AS link,
    'Base de données matériaux'                                   AS description,
    'database'                                                    AS icon,
    'brown'                                                         AS color;

-- Display list of projets
SELECT 'table' AS component, 
    'Liste des projets'   AS title, 
    'View'           AS markdown,
    'Nom'           AS markdown,
    TRUE             AS sort, 
    TRUE             AS search;

SELECT
    project_id               AS Id,
    '['||project_name||'](/e_project/project_hub_display_4.sql?project_id='||project_id||')' AS Nom,
    project_category        AS Categorie,
   '[Edit](/e_project/project_main_edit_4.sql?project_id='||project_id||')
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Delete](/e_project/project_main_delete_alert_4.sql?project_id='|| project_id||')'    AS View
FROM project
WHERE project_name IS NOT NULL AND project_status !='archived'
ORDER BY project_id ASC;
