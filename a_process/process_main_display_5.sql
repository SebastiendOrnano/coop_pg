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
    'datagrid'               AS component,
    'process_step_display'   AS id;
SELECT 
    '/a_process/process_main_form_5.sql'                        AS link,
    'Créer un  processus'                                       AS description,
    'automation'                                                AS icon,
    'green'                                                     AS color;
SELECT 
    '/a_process/process_archive_display_5.sql'                 AS link,
    'Processus archivés'                                       AS description,
    'archive'                                                  AS icon,
    'red'                                                      AS color;


SELECT 
    'title'     AS component,
    'PROCESSUS'    AS contents,
    3           AS level;

-- Display list of process
SELECT 
    'table'     AS component, 
    'Process'   AS title, 
    'View'      AS markdown, 
    TRUE        AS sort, 
    TRUE        AS search;

SELECT 
    process_id         AS ID,
    process_title      AS Process,
    process_category   AS Categorie,
    created_at         AS Created_at,
    '[Edit](/a_process/process_main_edit_5.sql?process_id='||process_id|| ')&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [View](/a_process/process_view_5.sql?process_id='||process_id|| ')&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Steps](/a_process/process_step_display_5.sql?process_id='||process_id||')&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Delete](/a_process/process_main_delete_alert_5.sql?process_id='||process_id||')'    AS View
FROM process WHERE process_status ='active'
ORDER BY created_at DESC;