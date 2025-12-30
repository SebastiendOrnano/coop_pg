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
    'Retour aux project actifs'         AS title,
    '/e_project/project_main_display_4.sql'             AS link;


SELECT 
    'divider' AS component,
    'Liste des project archivés'   AS contents;

-- Display list of projets
SELECT 'table' AS component, 
    'Liste des projets'   AS title, 
    JSON('{"name":"Open","tooltip":"désarchiver un projet","link":"/e_project/project_main_open_0.sql?project_id={id}","icon":"lock-open-2"}') as custom_actions,
    '/e_project/project_main_delete_alert_4.sql?project_id={id}' as delete_url,
    TRUE             AS sort, 
    TRUE             AS search;

SELECT
    project_id               AS Id,
    project_id               AS _sqlpage_id,
    project_name            AS Nom,
    project_category        AS Categorie
FROM project
WHERE project_name IS NOT NULL AND project_status ='archived'
ORDER BY project_id ASC;
