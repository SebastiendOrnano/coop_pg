SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_5.sql') AS properties;

SELECT 
    'title'        as component,
    'RSS'         as title,
    'Liste des liens à copier pour s''abonner à un flux RSS' as contents;

SELECT 
    'divider' as component;

SELECT
    'text' as component,
    'USERS :  notification nouveau compte'  as contents,
    'http://localhost:8080/a_rss/rss_users_5.sql' as contents_md,
    'rss'  as icon;
    
SELECT
    'text' as component,
    'FAQ notification messages reçus par le formulaire contact'  as contents,
    'http://localhost:8080/a_rss/rss_faq_5.sql' as contents_md,
    'rss'  as icon;
