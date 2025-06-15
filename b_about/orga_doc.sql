SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell.sql') AS properties;

SELECT 
    'title'   AS component,
    'Les document du projet Co-op' AS contents,
    TRUE      AS center;

SELECT 
    'divider'              AS component,
    'Rapports d''activité' AS contents,
    'left'                 AS position,
    'black'                AS color;

SELECT
    'table'          AS component, 
    'File'           AS markdown,
    'View'           AS markdown,
    'Bientôt en ligne !' AS empty_description,
    TRUE             AS sort;

SELECT       
   '['||orga_doc_title||']('||orga_doc_url||')'    AS File,
   orga_doc_date_publication     AS Date_Pub,
   orga_doc_date_period          AS Periode
FROM orga_docs
WHERE orga_doc_status = 'active' AND orga_doc_category = 'annual_report'
ORDER BY created_at DESC;

SELECT 
    'divider'              AS component,
    'Bilans'               AS contents,
    'left'                 AS position,
    'black'                  AS color;

SELECT 
    'table'          AS component, 
    'File'           AS markdown,
    'View'           AS markdown,
    'Bientôt en ligne !' AS empty_description,
    TRUE             AS sort;

SELECT       
   '['||orga_doc_title||']('||orga_doc_url||')'    AS File,
   orga_doc_date_publication     AS Date_Pub,
   orga_doc_date_period          AS Periode
FROM orga_docs
WHERE orga_doc_status = 'active' AND  orga_doc_category ='annual_results'
ORDER BY created_at DESC;

SELECT 
    'divider'              AS component,
    'Autres documents'    AS contents,
    'left'                 AS position,
    'black'                 AS color;

SELECT 'table' AS component, 
    'Autres documents'   AS title,
    'File'           AS markdown,
    'View'           AS markdown,
    'Bientôt en ligne !' AS empty_description,
    TRUE             AS sort;

SELECT       
   '['||orga_doc_title||']('||orga_doc_url||')'    AS File,
   orga_doc_date_publication     AS Date_Pub,
   orga_doc_date_period          AS Periode
FROM orga_docs
WHERE orga_doc_status = 'active' AND  orga_doc_category ='unknown'
ORDER BY created_at DESC;