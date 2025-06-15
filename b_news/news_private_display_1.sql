SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_1.sql') AS properties;


SELECT 
    'divider'                   AS component,
    'Nos dernières actualités internes'  AS contents,
    'left'                      AS position,
    6                           AS size,
    'red'                      AS color;

SELECT 
    'foldable'        AS component,
    'news_list_id'    AS id;

SELECT 
    'news_content_class'                    AS class,
    DATE(news_date)||' |  '||news_title  AS title,
    CASE 
    WHEN news_img_url IS NULL OR news_img_url = '' THEN  news_content
    ELSE 
    '![]('||news_img_url||')

'|| news_content
    END  AS description_md
   FROM news
   WHERE news_status='active' AND news_date > (NOW() - INTERVAL '3 months') AND news_public_private='private';