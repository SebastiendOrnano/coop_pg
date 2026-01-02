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
    'liste des projets'            AS title,
    '/e_project/project_main_display_3.sql'     AS link;
 SELECT 
    'hub du projet'            AS title,
    '/e_project/project_hub_display_3.sql?project_id='||$project_id     AS link; SELECT 
    'breadcrumb' AS component;
SELECT 
    'Gestion des docs'            AS title,
    '/e_project_docs/project_doc_main_display_3.sql?project_id='||$project_id     AS link;

    


SELECT 
    'button' AS component,
    'L'     AS size;
SELECT 
    '/e_project_docs/project_doc_form_3.sql?project_id='||$project_id   AS link,
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
  '[Edit](/e_project_docs/project_doc_edit_3.sql?project_doc_id='||project_doc_id||'&project_id='||project_id||')'    AS View
FROM project_docs
WHERE project_id = $project_id::INTEGER AND project_doc_status != 'archived'
ORDER BY created_at DESC;
