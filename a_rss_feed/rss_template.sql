SELECT 'http_header' AS component, 'application/rss+xml' AS content_type;

SELECT 'shell-empty' AS component;

SET rss_id=4

SELECT
  'rss' AS component,
  rss_title AS title,
  rss_link AS link,
  rss_description AS description,
  'fr' AS language,
  rss_category AS category
  FROM rss WHERE rss_id=$rss_id;

SET rss_item_title= SELECT rss_item_title FROM rss WHERE rss_id=$rss_id;
SET rss_item_link= SELECT rss_item_link FROM rss WHERE rss_id=$rss_id;
SET rss_item_description= SELECT rss_item_description FROM rss WHERE rss_id=$rss_id;
SET rss_item_table= SELECT rss_item_table FROM rss WHERE rss_id=$rss_id;


SELECT
  $rss_item_title AS title,
  $rss_item_link AS link,
  $rss_item_description AS description,
  FROM $rss_item_table;