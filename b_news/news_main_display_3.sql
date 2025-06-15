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
    'datagrid'              AS component,
    'panel_news_display' AS id,
    'Gestion des news' AS title;

SELECT 
    '/b_news/news_main_form_3.sql'     AS link,
    'Création d''une news'             AS description,
    'user-plus'                        AS icon,
    'yellow'                            AS color;


SELECT 
    '/b_news/news_past_display_3.sql'     AS link,
    'Visualiser les news > 3 mois '          AS description,
    'calendar-off'                          AS icon,
    'green'                                  AS color;

-- Display list of organizations
SELECT 'table' AS component, 
    'Liste des news'   AS title, 
    'View'           AS markdown,
    TRUE             AS sort, 
    TRUE             AS search;

SELECT
    news_id                        AS Id,
    news_title                     AS Titre,
    news_status                    AS Status,
    news_public_private            AS PublicPrivate,
    news_date                      AS Date,
   '[Preview](/b_news/news_private_display_3.sql?news_id=' || news_id || ')&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Edit](/b_news/news_main_edit_3.sql?news_id=' || news_id||')'    AS View
FROM news
WHERE news_title IS NOT NULL AND news_status !='archived' AND news_date > (NOW() - INTERVAL '3 months')
ORDER BY news_id ASC;
