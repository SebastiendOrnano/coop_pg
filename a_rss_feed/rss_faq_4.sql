SELECT 'http_header' AS component, 'application/rss+xml' AS content_type;
SELECT 'shell-empty' AS component;
SELECT
  'rss' AS component,
  'Suivi des messages' AS title,
  'http://localhost:8080/b_faq/faq_main_display_4.sql' AS link,
  'Suivi des messages envoyés sur le site Coop' AS description,
  'fr' AS language;
SELECT
  'Bonjour' AS title,
  'http://localhost:8080/b_faq/faq_main_display_4.sql' AS link,
  'dernier message reçu' AS description;