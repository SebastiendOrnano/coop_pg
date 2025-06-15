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

SELECT 
    'foldable'        AS component,
    'news_list_id'    AS id;
SELECT 
    'news_content_id'              AS id,
    DATE(news_date)||' |  '||news_title  AS title,
    CASE 
    WHEN news_img_url IS NULL OR news_img_url = '' THEN  news_content
    ELSE 
    '![]('||news_img_url||')

'|| news_content
    END  AS description_md
   FROM news
   WHERE news_id=$news_id::INTEGER;