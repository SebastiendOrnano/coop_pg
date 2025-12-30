SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;
SET orga_id = SELECT orga_id FROM orga_dept WHERE orga_dept_id = $orga_dept_id::INTEGER;

SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion Superviseur'         AS title,
    '/a_panels/panel_supervisor_4.sql' AS link;
SELECT 
    'Gestion des organisations'            AS title,
    '/b_orga/orga_main_display_4.sql' AS link;
SELECT 
   '/b_orga_dept/orga_dept_main_display_4.sql?orga_id='||$orga_id   AS link,
    'Retour à  l''organisation'                  AS title;


SELECT 
    'datagrid'              AS component,
    '/b_orga_doc/panel_orga_dept_doc_display' AS id,
    'Gestion des documents de l''organisation' AS title;
SELECT 
     '/b_orga_doc/orga_doc_dept_form_4.sql?orga_dept_id='||$orga_dept_id             AS link,
    'Créer un nouveau document'                          AS description,
    'file-download'                                      AS icon,
    'green'                                              AS color;
SELECT 
     '/b_orga_doc/orga_doc_archive_display_4.sql?orga_dept_id='||$orga_dept_id             AS link,
    'Doc archivés'                                     AS description,
    'archive'                                           AS icon,
    'red'                                              AS color;

SELECT 
    'title'     AS component,
    'Département '    AS contents,
    3           AS level;
SELECT 
    'form' AS component,
    '' AS validate;
SELECT 
    'orga_id' AS name,
    'hidden' AS type,
    $orga_id AS value,
    'id' AS label;
SELECT 
    'orga_dept_id' AS name,
    'hidden' AS type,
    $orga_dept_id AS value,
    'id' AS label;
SELECT
    'orga_dept_name' AS name,
    'text' AS type,  
    'Nom de la filiale ou du département' AS label,
     6 AS width,
    (SELECT orga_dept_name  FROM orga_dept WHERE orga_dept_id = $orga_dept_id::INTEGER ) AS value;
SELECT
    'orga_name' AS name,
    'text' AS type,  
    'Nom de la organisation mère' AS label,
    6 AS width,
    (SELECT o.orga_name  FROM orga_dept AS d
    LEFT JOIN orga AS o
    ON o.orga_id = d.orga_id    
    WHERE d.orga_dept_id = $orga_dept_id::INTEGER ) AS value;


SELECT 
    'title'     AS component,
    'Liste des documents'    AS contents,
    3           AS level;

SELECT 
    'table'               AS component, 
    TRUE                  AS sort, 
    '/b_orga_doc/orga_doc_main_edit_4.sql?orga_doc_id={id}' as edit_url,
    '/b_orga_doc/orga_doc_main_delete_alert1_4.sql?orga_doc_id={id}' as delete_url,
    'File'                AS markdown, 
    TRUE                  AS search;

SELECT
    '['||orga_doc_title||']('||orga_doc_url||')'    AS File,
   orga_doc_date_publication  AS Date_Pub,
   orga_doc_id                AS _sqlpage_id,
   orga_doc_date_period       AS Period,
   orga_doc_category          AS Categorie,
   orga_doc_edition           AS Edition,
   orga_doc_status      AS Publication
FROM orga_dept_docs
WHERE orga_dept_id = $orga_dept_id::INTEGER AND orga_doc_status != 'archived'
ORDER BY created_at DESC;
