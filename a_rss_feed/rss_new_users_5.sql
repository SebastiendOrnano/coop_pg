SELECT 'http_header' AS component, 'application/rss+xml' AS content_type;
SELECT 'shell-empty' AS component;
SELECT
  'rss' AS component,
  'Suivi des inscriptions' AS title,
  'http://localhost:8080/a_users/users_new_display_5.sql' AS link,
  'Suivi des inscriptions sur le site Coop' AS description,
  'fr' AS language;

SELECT
  'Nouvelle inscription :    ' ||username AS title,
  'http://localhost:8080/a_users/users_new_display_5.sql' AS link,
 '<strong>Email:&nbsp;&nbsp; </strong> ' || user_email || '<br /><strong> Motivation:&nbsp;&nbsp;</strong> ' || user_short_cv AS description

FROM
  users
WHERE user_status IS NULL OR user_status = '' OR user_role = '' OR user_role IS NULL;