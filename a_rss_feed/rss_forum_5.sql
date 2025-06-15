SELECT 'http_header' AS component, 'application/rss+xml' AS content_type;
SELECT 'shell-empty' AS component;
SELECT
  'rss' AS component,
  'Suivi des inscriptions' AS title,
  'http://localhost:8080/c_forum/forum_main_display_5.sql' AS link,
  'Suivi des nouvelles discussion sur le forum sur le site Coop' AS description,
  'fr' AS language;

SELECT
  topic_name AS title,
  'http://localhost:8080/c_forum/forum_main_display_5.sql' AS link

FROM
  forum_topics
WHERE forum_type ='forum';