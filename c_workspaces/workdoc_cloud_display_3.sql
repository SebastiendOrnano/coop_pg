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
     '/c_workspaces/workspace_main_display_3.sql'             AS link,
    'Espaces de travail'           AS title;
SELECT 
    '/c_workspaces/workspace_hub_display_3.sql?workspace_id='||$workspace_id  AS link,
    'Espace du groupe de travail'                                      AS title;

SELECT 
    'button' AS component,
    'L'     AS size;
SELECT 
    '/c_workspaces/workdoc_cloud_form_4.sql?workspace_id='||$workspace_id   AS link,
    'green'                              AS color,
    TRUE                                 AS important,
    'Ajouter un nouveau document en ligne'     AS title,
    'cloud-share'                      AS icon;

-- Display list of  docs

SELECT 'table' AS component, 
    'Liste des documents'   AS title,
    'Titre'           AS markdown,
    '/c_workspaces/workdoc_cloud_edit_4.sql?workdoc_cloud_id={id}' as edit_url,
    TRUE             AS sort, 
    TRUE             AS search;

SELECT
    workdoc_cloud_id        AS Id,
    workdoc_cloud_id        as _sqlpage_id,
   '['||workdoc_cloud_title||']('||workdoc_cloud_url||')'    AS Titre,
   workdoc_cloud_category             AS Categorie
FROM workdocs_cloud
WHERE workspace_id=$workspace_id::INTEGER AND workdoc_cloud_status != 'archived'
ORDER BY created_at DESC;
