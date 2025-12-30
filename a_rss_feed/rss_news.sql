SELECT 'http_header' AS component, 'application/rss+xml' AS content_type;
SELECT 'shell-empty' AS component;
SELECT
  'rss' AS component,
  'Suivi des actus du site COOP' AS title,
  'http://localhost:8080/b_news/news_public_display.sql' AS link,
  'Suivi des actualités sur le site Coop' AS description,
  'fr' AS language,
  'Social' AS category;

SELECT
  'Nouvelle actu :    ' ||news_title AS title,
 'http://localhost:8080/b_news/news_public_display.sql' AS link,
  SUBSTR( news_content, 1, 50)||'...'   AS description

FROM
    news
WHERE news_public_private='public' AND news_status='online';