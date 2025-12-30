SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion Superviseur'                      AS title,
    'arrow_left_double'                  AS icon,
    '/a_panels/panel_supervisor_4.sql'        AS link;


SELECT 
    'title'        AS component,
    'PROCESSUS'    AS contents,
    3              AS level;

SELECT 
    'list'      AS component;

SELECT 
    process_title                                                   AS title,
    '/a_process/process_view_4.sql?process_id='||process_id          AS link
FROM process
WHERE process_category='supervisor' and process_status='active'
ORDER BY created_at DESC;