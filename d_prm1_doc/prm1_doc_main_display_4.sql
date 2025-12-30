SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SET prm1_name = SELECT CONCAT(prm1_first_name, '   ',prm1_last_name) FROM prm1 WHERE prm1_id =$prm1_id::INTEGER;

SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion Superviseur'         AS title,
    '/a_panels/panel_supervisor_4.sql' AS link;
SELECT 
    'Gestion des personnes physiques'            AS title,
    '/d_prm1/prm1_main_display_4.sql?prm1_id='||$prm1_id AS link;

-- Supervisor panel to manage members
SELECT 
    'datagrid'              AS component,
    'panel_prm1_doc_display' AS id,
    'Gestion des documents de : '||$prm1_name AS title;
SELECT 
    '/d_prm1_doc/prm1_doc_main_form_4.sql?prm1_id='||$prm1_id         AS link,
    'Création d''un nouveau document'                                 AS description,
    'books'                                                           AS icon,
    'yellow'                                                          AS color;
SELECT 
    '/d_prm1_doc/prm1_doc_archive_display_4.sql?prm1_id='||$prm1_id         AS link,
    'Documents archivés'                                                   AS description,
    'archive'                                                              AS icon,
    'green'                                                                AS color;
SELECT 
    '/d_prm1_doc/prm1_doc_select_display_4.sql?prm1_id='||$prm1_id         AS link,
    'Actualiser une série de documents'                                    AS description,
    'refresh'                                                              AS icon,
    'green'                                                                AS color;

    

-- Display list of  docs

SELECT 'table' AS component, 
    'Liste des documents'   AS title,
    'Titre'           AS markdown,
    '/d_prm1_doc/prm1_doc_main_edit_4.sql?prm1_doc_id={id}' as edit_url,
    '/d_prm1_doc/prm1_doc_main_delete_alert1_4.sql?prm1_doc_id={id}' as delete_url,
    TRUE             AS sort, 
    TRUE             AS search;

SELECT
    prm1_doc_id        AS Id,
    prm1_doc_id        AS _sqlpage_id,
   '['||prm1_doc_title||']('||prm1_doc_url||')'    AS Titre,
   prm1_doc_date_publication     AS Date_Pub,
   prm1_doc_category             AS Categorie
FROM prm1_doc
WHERE prm1_doc_status != 'archived'
ORDER BY created_at DESC;
