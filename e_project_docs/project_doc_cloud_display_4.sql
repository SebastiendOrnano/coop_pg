SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    '/a_panels/panel_supervisor_4.sql'         AS link,
    'Retour au tableau de bord éditeur'    AS title;
SELECT
    '/e_project_docs/project_hub_display_4.sql?project_id='||$project_id  AS link,
    'Retour hub du groupe de travail' AS title;

SELECT 
    'button' AS component,
    'L'     AS size;
SELECT 
    '/e_project_docs/project_doc_form_4.sql?project_id='||$project_id   AS link,
    'green'                              AS color,
    TRUE                                 AS important,
    'Ajouter un nouveau document en ligne'     AS title,
    'cloud-share'                      AS icon;

-- Display list of  docs

SELECT 'table' AS component, 
    'Liste des documents'   AS title,
    'Titre'           AS markdown,
    'View'           AS markdown,
    TRUE             AS sort, 
    TRUE             AS search;

SELECT
    project_doc_id        AS Id,
   '['||project_doc_title||']('||project_doc_url||')'    AS Titre,
   project_doc_category             AS Categorie,
  '[Edit](/e_project_docs/project_doc_edit_4.sql?project_doc_id='||project_doc_id||'&project_id='||project_id||')&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Delete](/e_project_docs/project_doc_delete_alert1_4.sql?project_doc_id='||project_doc_id||'&project_id='||project_id||')'    AS View
FROM project_docs
WHERE project_id = $project_id::INTEGER AND project_doc_status != 'archived'
ORDER BY created_at DESC;
