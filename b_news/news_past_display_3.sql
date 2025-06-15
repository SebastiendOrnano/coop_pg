SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_3.sql') AS properties;

SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion éditeur'         AS title,
    '/a_panels/panel_editor_3.sql' AS link;
SELECT 
    'Gestion des actus'         AS title,
    '/b_news/news_main_display_3.sql' AS link;



-- Display list of organizations
SELECT 'table' AS component, 
    'Liste des news'   AS title, 
    'View'           AS markdown,
    TRUE             AS sort, 
    TRUE             AS search;

SELECT
    news_id                        AS Id,
    news_title                     AS Titre,
    news_status                    AS Statut,
    news_date                      AS Date,
   '[Edit](/b_news/news_main_edit_4.sql?news_id=' || news_id || ')&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Delete](/b_news/news_main_delete_0.sql?news_id=' || news_id|| ')'    AS View
FROM news
WHERE  news_date < (NOW() - INTERVAL '3 months')
ORDER BY news_id ASC;
