SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion Superviseur'         AS title,
    '/a_panels/panel_supervisor_4.sql' AS link;

SELECT 
    'datagrid'              AS component,
    'panel_news_display' AS id,
    'Gestion des news' AS title;

SELECT 
    '/b_news/news_main_form_4.sql'     AS link,
    'Création d''une news'             AS description,
    'user-plus'                        AS icon,
    'yellow'                            AS color;

SELECT 
    '/b_news/news_archive_display_4.sql'     AS link,
    'Visualiser les news archivées'          AS description,
    'archive'                                AS icon,
    'green'                                  AS color;

SELECT 
    '/b_news/news_past_display_4.sql'     AS link,
    'Visualiser les news > 3 mois '          AS description,
    'calendar-off'                          AS icon,
    'green'                                  AS color;

-- Display list of organizations
SELECT 'table' AS component, 
    'Liste des news'   AS title, 
    JSON('{"name":"View","tooltip":"View","link":"/b_news/news_private_display_4.sql?news_id={id}","icon":"news"}') as custom_actions,
    '/b_news/news_main_edit_4.sql?news_id={id}' as edit_url,
    '/b_news/news_main_delete_0.sql?news_id={id}' as delete_url,
    TRUE             AS sort, 
    TRUE             AS search;

SELECT
    news_id                        AS Id,
    news_id                        as _sqlpage_id,
    news_title                     AS Titre,
    news_status                    AS Status,
    news_public_private            AS PublicPrivate,
    news_date                      AS Date
FROM news
WHERE news_title IS NOT NULL AND news_status !='archived' AND news_date > (NOW() - INTERVAL '3 months')
ORDER BY news_id ASC;
