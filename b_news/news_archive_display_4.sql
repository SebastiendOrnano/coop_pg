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
    'Gestion des news'            AS title,
    '/b_news/news_main_display_4.sql'      AS link;



-- Display list of organizations
SELECT 'table' AS component, 
    'Liste des news'   AS title, 
    'View'           AS markdown,
    TRUE             AS sort, 
    TRUE             AS search;

SELECT
    news_id                      AS Id,
   news_title                    AS Titre,
   news_status       AS Statut,
   '[Edit](/b_news/news_main_edit_4.sql?news_id=' || news_id || ')&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Delete](/b_news/news_main_delete_0.sql?news_id=' || news_id|| ')'    AS View
FROM news
WHERE news_title IS NOT NULL AND news_status='archived'
ORDER BY news_id ASC;
