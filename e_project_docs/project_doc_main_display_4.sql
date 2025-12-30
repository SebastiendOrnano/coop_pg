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
    'Retour au hub du projet'            AS title,
    '/e_project/project_hub_display_4.sql?project_id='||$project_id     AS link; 

SELECT 
    'datagrid'              AS component,
    'panel_project_doc_display' AS id,
    'Gestion des documents de l''organisation :  '|| $project_doc_name AS title;
SELECT 
    '/e_project_docs/project_doc_main_form_4.sql?project_id='||$project_id          AS link,
    'Création d''un nouveau document local'          AS description,
    'books'                                    AS icon,
    'yellow'                                   AS color;
SELECT 
    '/e_project_docs/project_doc_cloud_form_4.sql?project_id='||$project_id          AS link,
    'Création d''un nouveau document en ligne'          AS description,
    'cloud-network'                                    AS icon,
    'red'                                   AS color;
SELECT 
    '/e_project_docs/project_doc_select_display_4.sql?project_id='||$project_id         AS link,
    'Actualiser une série de documents'                  AS description,
    'refresh'                                              AS icon,
    'green'                                             AS color;
   

-- Display list of  docs

SELECT 'table' AS component, 
    'Liste des documents'   AS title,
    'Titre'           AS markdown,
    '/e_project_docs/project_doc_main_edit_4.sql?project_doc_id={id}' as edit_url,
    '/e_project_docs/project_doc_main_delete_alert1_4.sql?project_doc_id={id}' as delete_url,
    TRUE             AS sort, 
    TRUE             AS search;

SELECT
    project_doc_id        AS Id,
    project_doc_id        AS _sqlpage_id,
    CASE 
    WHEN project_doc_local_cloud='local' THEN '['||project_doc_title||']('||project_doc_url||')' 
    WHEN project_doc_local_cloud='cloud' THEN '['||project_doc_title_link||']('||project_doc_cloud_url||')' 
    END   AS Titre,
    project_doc_category             AS Categorie,
    CASE 
    WHEN project_doc_local_cloud='local' THEN project_doc_format   
    WHEN project_doc_local_cloud='cloud' THEN project_doc_cloud_format  
    END                              AS Format,
    project_doc_type               AS Type,
    project_doc_local_cloud                AS LocalCloud
FROM project_docs
WHERE project_id = $project_id::INTEGER AND project_doc_status != 'archived'
ORDER BY created_at DESC;
