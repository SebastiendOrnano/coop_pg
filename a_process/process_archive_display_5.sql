SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_5.sql') AS properties;

SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion admin'         AS title,
    '/a_panels/panel_admin_5.sql' AS link;
SELECT 
    'Processus actifs'         AS title,
    '/a_process/process_main_display_5.sql' AS link;


SELECT 
    'title'     AS component,
    'PROCESSUS'    AS contents,
    3           AS level;

-- Display list of process
SELECT 
    'table'     AS component, 
    'Process'   AS title, 
    '/a_process/process_main_edit_5.sql?process_id={id}' as edit_url,
    '/a_process/process_main_delete_alert_5.sql?process_id={id}' as delete_url,
    JSON('{"name":"view","tooltip":"Voir le process","link":"/a_process/process_view_5.sql?process_id={id}","icon":"sort-ascending-shapes"}') as custom_actions,
    JSON('{"name":"step","tooltip":"Étapes","link":"/a_process/process_step_display_5.sql?process_id={id}","icon":"list"}') as custom_actions,
    TRUE        AS sort, 
    TRUE        AS search;

SELECT 
    process_id         AS ID,
    process_id        as _sqlpage_id,
    process_title      AS Process,
    process_category   AS Categorie,
    created_at         AS Created_at
FROM process WHERE process_status !='active'
ORDER BY created_at DESC;