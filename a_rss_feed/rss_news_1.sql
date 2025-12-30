SELECT 'http_header' AS component, 'application/rss+xml' AS content_type;
SELECT 'shell-empty' AS component;
SELECT
  'rss' AS component,
  'Suivi des actus internes' AS title,
  'http://localhost:8080/b_news/news_private_display_1.sql' AS link,
  'Suivi des actus internes sur le site Coop' AS description,
  'fr' AS language,
  'Social' AS category;

SELECT
  'Nouvelle actu :    ' ||news_title AS title,
  'http://localhost:8080/b_news/news_private_display_1.sql' AS link,
  SUBSTR( news_content, 1, 50)||'...'   AS description

FROM
    news
WHERE news_public_private='private' AND news_status='online';