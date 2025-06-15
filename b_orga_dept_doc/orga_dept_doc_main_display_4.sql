SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SET orga_dept_name = SELECT orga_dept_name FROM orga_dept WHERE orga_dept_id=$orga_dept_id::INTEGER;
SET orga_id = SELECT orga_id FROM orga_dept WHERE  orga_dept_id=$orga_dept_id::INTEGER;

SELECT 
    'breadcrumb' as component;
SELECT 
    'Home' as title,
    '/'    as link;
SELECT 
    'Gestion Superviseur'         as title,
    '/a_panels/panel_supervisor_4.sql' as link;

SELECT 
   '/b_orga_dept/orga_dept_main_display_4.sql?orga_id='||$orga_id   AS link,
    'Retour à  l''organisation'                  AS title;


-- Supervisor panel to manage members
SELECT 
    'datagrid'              as component,
    'panel_orga_doc_display' as id,
    'Gestion des documents de l''organisation : '||$orga_dept_name as title;

SELECT 
    '/b_orga_dept_doc/orga_dept_doc_main_form_4.sql'          as link,
    'Création d''un nouveau document'          as description,
    'books'                                    as icon,
    'yellow'                                   as color;
SELECT 
    '/b_orga_dept_doc/orga_dept_doc_archive_display_4.sql?orga_dept_id='||$orga_dept_id   as link,
    'Docs archivés'          as description,
    'archive'                as icon,
    'blue'                   as color;
SELECT 
    '/b_orga_dept_doc/orga_dept_doc_select_display_4.sql?orga_dept_id='||$orga_dept_id   as link,
    'Actualiser une série de documents'      as description,
    'refresh'                                as icon,
    'green'                                  as color;


-- Display list of  docs

SELECT 'table' AS component, 
    'Liste des documents'   AS title,
    'Titre'           AS markdown,
    'View'           AS markdown,
    TRUE             AS sort, 
    TRUE             AS search;

SELECT
    orga_doc_id        AS Id,
   '['||orga_doc_title||']('||orga_doc_url||')'    AS Titre,
   orga_doc_date_publication     AS Date_Pub,
   orga_doc_date_period          AS Period,
   orga_doc_category             AS Categorie,
   orga_doc_edition              as Edition,
   orga_doc_status               AS Pubication,
  '[Edit](/b_orga_dept_doc/orga_dept_doc_main_edit_4.sql?orga_doc_id='||orga_doc_id||')&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Delete](/b_orga_dept_doc/orga_dept_doc_main_delete_alert1_4.sql?orga_doc_id='||orga_doc_id||')&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Remove](/b_orga_dept_doc/orga_dept_doc_main_delete_alert2_4.sql?orga_doc_id='||orga_doc_id||')'    AS View
FROM orga_docs
WHERE orga_doc_status != 'archived' AND orga_dept_id=$orga_dept_id::INTEGER
ORDER BY created_at DESC;
