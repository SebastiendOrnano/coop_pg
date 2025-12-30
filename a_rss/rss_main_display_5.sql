SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_5.sql') AS properties;

SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion Admin'         AS title,
    '/a_panels/panel_admin_5.sql' AS link;



SELECT 
    'datagrid'               AS component,
    'process_step_display'   AS id;
SELECT 
    '/a_rss/rss_main_form_5.sql'    AS link,
    'Créer un  lien RSS'                                       AS description,
    'rss'                                                      AS icon,
    'green'                                                     AS color;
SELECT 
    '/a_rss/rss_archive_display_5.sql'    AS link,
    'liens RSS archivés'                                       AS description,
    'archive'                                                  AS icon,
    'blue'                                                    AS color;

SELECT 
    'title'        AS component,
    'RSS'         AS title,
    'Liste des liens à copier pour s''abonner à un flux RSS' AS contents;

SELECT 
    'divider' AS component;

SELECT 
    'table'               AS component, 
    'Étapes du processus' AS title, 
    TRUE                  AS sort, 
    '/a_rss/rss_main_edit_5.sql?rss_id={id}' as edit_url,
    '/a_rss/rss_main_delete_0.sql?rss_id={id}' as delete_url,
    FALSE                 AS search;

SELECT
    rss_id                 AS Id,
    rss_id                 as _sqlpage_id,
    rss_title              AS Title,
    rss_feed               AS link,
    rss_category           AS Catégorie
FROM rss WHERE rss_status ='active'
ORDER BY created_at ASC;

