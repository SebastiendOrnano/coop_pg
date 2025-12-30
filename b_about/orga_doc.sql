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
   '['||o.orga_doc_title||']('||o.orga_doc_url||')'    AS File,
   o.orga_doc_date_publication     AS Date_Pub,
   o.orga_doc_date_period          AS Periode
    FROM orga_dept_docs as o 
    LEFT JOIN (select orga_dept_id, orga_dept_name, orga_dept_master FROM orga_dept) as d 
    ON o.orga_dept_id=d.orga_dept_id 
WHERE o.orga_doc_status = 'active' AND  o.orga_doc_category ='annual_report'  AND d.orga_dept_master = 'master' 
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
   '['||o.orga_doc_title||']('||o.orga_doc_url||')'    AS File,
   o.orga_doc_date_publication     AS Date_Pub,
   o.orga_doc_date_period          AS Periode
    FROM orga_dept_docs as o 
    LEFT JOIN (select orga_dept_id, orga_dept_name, orga_dept_master FROM orga_dept) as d 
    ON o.orga_dept_id=d.orga_dept_id 
WHERE o.orga_doc_status = 'active' AND  o.orga_doc_category ='annual_results' AND d.orga_dept_master = 'master' 
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
   '['||o.orga_doc_title||']('||o.orga_doc_url||')'    AS File,
   o.orga_doc_date_publication     AS Date_Pub,
   o.orga_doc_date_period          AS Periode
    FROM orga_dept_docs as o 
    LEFT JOIN (select orga_dept_id, orga_dept_name, orga_dept_master FROM orga_dept) as d 
    ON o.orga_dept_id=d.orga_dept_id 
WHERE o.orga_doc_status = 'active' AND  o.orga_doc_category ='unknown' AND d.orga_dept_master = 'master' 
ORDER BY created_at DESC;