SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_1.sql') AS properties;

SELECT 
    'button' AS component,
    'L'     AS size;
SELECT 
    '/c_debug/debug_main_form_1.sql'     AS link,
    'green'                              AS color,
    TRUE                                 AS important,
    'Lancer une nouvelle discussion'     AS title,
    'arrows-random'                      AS icon;


-- Get the last inserted topic ID
SET topic_id = (SELECT MAX(topic_id) FROM forum_topics WHERE topic_name = :topic_name);

-- Display list of forum_topics
SELECT 'table' AS component, 
    'Forum forum_topics'   AS title, 
    JSON('{"name":"Discussion","tooltip":"Entrer dans a discussion","link":"/c_debug/debug_message_display_1.sql?topic_id={id}","icon":"messages"}') as custom_actions,
    TRUE             AS sort, 
    TRUE             AS search;

SELECT       -- NOTE: the dots join values FROM the forum_topics and forum_messages tables
    t.topic_id       AS ID,
    t.topic_name     AS Topic,
    t.topic_category AS Categorie,
    to_char(m.created_at AT TIME ZONE 'Europe/Paris', 'YYYY-MM-DD HH24:MI')     AS Created_at,
    u.username                   AS Contributeur
FROM forum_topics AS t
LEFT JOIN (
    SELECT topic_id, MAX(created_at) AS created_at FROM forum_messages
    GROUP BY topic_id) AS m 
    ON t.topic_id = m.topic_id
LEFT JOIN (select username, user_id from users) AS u
ON u.user_id=t.topic_author_id
WHERE  t.topic_status !='archived' AND t.forum_type='debug'
ORDER BY t.topic_status DESC, m.created_at DESC;