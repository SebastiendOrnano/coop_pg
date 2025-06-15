SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    '/a_panels/panel_supervisor_4.sql'         AS link,
    'Retour au tableau de bord superviseur'    AS title;
SELECT
    '/c_workspaces/workspace_hub_display_4.sql?workspace_id='||$workspace_id  AS link,
    'Retour hub du groupe de travail' AS title;

SELECT 
    'button' AS component,
    'L'     AS size;
SELECT 
    '/c_workspaces/workdoc_form_4.sql?workspace_id='||$workspace_id   AS link,
    'green'                              AS color,
    TRUE                                 AS important,
    'Ajouter un nouveau document'     AS title,
    'book-upload'                      AS icon;

-- Display list of  docs

SELECT 'table' AS component, 
    'Liste des documents'   AS title,
    'Titre'           AS markdown,
    'View'           AS markdown,
    TRUE             AS sort, 
    TRUE             AS search;

SELECT
    workdoc_id        AS Id,
   '['||workdoc_title||']('||workdoc_url||')'    AS Titre,
    workdoc_version             AS Version,
    updated_at                 AS Last_modif,
   workdoc_category             AS Categorie,
  '[Edit](/c_workspaces/workdoc_edit_4.sql?workdoc_id='||workdoc_id||'&workspace_id='||workspace_id||')&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Delete](/c_workspaces/workdoc_delete_alert1_4.sql?workdoc_id='||workdoc_id||'&workspace_id='||workspace_id||')'    AS View
FROM workdocs
WHERE workspace_id=$workspace_id::INTEGER AND workdoc_status != 'archived'
ORDER BY created_at DESC;
