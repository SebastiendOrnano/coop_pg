SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_3.sql') AS properties;

SELECT 
    'breadcrumb' as component;
SELECT 
    'Home' as title,
    '/'    as link;
SELECT 
    'Gestion Editeur'                      as title,
    'arrow_left_double'                  as icon,
    '/a_panels/panel_editor_3.sql'        as link;


SELECT 
    'title'        as component,
    'PROCESSUS'    as contents,
    3              as level;

SELECT 
    'list'      AS component;

SELECT 
    process_title                                                   AS title,
    '/a_process/process_view_3.sql?process_id='||process_id          AS link
FROM process
WHERE process_category='editor' and process_status='active'
ORDER BY created_at DESC;