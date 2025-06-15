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
    'Liens rss actifs'         AS title,
    '/a_rss/rss_main_display_5.sql' AS link;



SELECT 
    'title'        AS component,
    'RSS'         AS title,
    'Liste des liens archivés' AS contents;

SELECT 
    'divider' AS component;

SELECT 
    'table'               AS component, 
    'Étapes du processus' AS title, 
    TRUE                  AS sort, 
    'View'                AS markdown, 
    FALSE                 AS search;

SELECT
    rss_id                 AS Id,
    rss_title              AS Title,
    rss_feed               AS link,
    rss_category           AS Catégorie,
   '[Edit](/a_rss/rss_main_edit_5.sql?rss_id='||rss_id|| ') &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [Delete](/a_rss/rss_main_delete_0.sql?rss_id='||rss_id||')'    AS View
FROM rss WHERE rss_status !='active'
ORDER BY created_at ASC;

