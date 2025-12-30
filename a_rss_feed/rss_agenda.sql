SELECT 'http_header' AS component, 'application/rss+xml' AS content_type;

SELECT 'shell-empty' AS component;

SELECT
  'rss' AS component,
  rss_title AS title,
  rss_link AS link,
  rss_description AS description,
  'fr' AS language,
  rss_category AS category
FROM rss WHERE rss_id='3';

SELECT
  rss_item_title AS title,
  rss_item_link AS link,
  rss_item_description AS description

FROM rss WHERE rss_id='3';