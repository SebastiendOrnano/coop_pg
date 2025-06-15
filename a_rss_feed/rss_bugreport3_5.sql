SELECT 'http_header' AS component, 'application/rss+xml' AS content_type;
SELECT 'shell-empty' AS component;
SELECT
  'rss' AS component,
  'Suivi des inscriptions' AS title,
  'http://localhost:8080/c_debug/debug_main_display_5.sql' AS link,
  'Suivi des inscription sur le site Coop' AS description,
  'fr' AS language,
  'Social' AS category,
  FALSE AS explicit,
  'https://sql.datapage.app/favicon.ico' AS image_url,
  'admin Coop' AS author,
  'episodic' AS type;

SELECT
  topic_name AS title,
  'http://localhost:8080/c_debug/debug_main_display_5.sql' AS link,
   topic_category AS description

FROM
    forum_topics;