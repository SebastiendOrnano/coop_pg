SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_5.sql') AS properties;

SELECT 
    'title'        AS component,
    'RSS'         AS title,
    'Liste des liens à copier pour s''abonner à un flux RSS' AS contents;

SELECT 
    'divider' AS component;

SELECT
    'text' AS component,
    'USERS :  notification nouveau compte'  AS contents,
    'http://localhost:8080/a_rss/rss_users_5.sql' AS contents_md,
    'rss'  AS icon;
    
SELECT
    'text' AS component,
    'FAQ notification messages reçus par le formulaire contact'  AS contents,
    'http://localhost:8080/a_rss/rss_faq_5.sql' AS contents_md,
    'rss'  AS icon;
