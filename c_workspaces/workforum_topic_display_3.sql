SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_3.sql') AS properties;

SET user_id = (
    SELECT u.user_id  FROM users as u
    LEFT JOIN (SELECT session_id, user_id, session_token FROM sessions) as s
    ON s.user_id = u.user_id
    WHERE s.session_token = sqlpage.cookie('session_token')
);

SELECT
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion éditeur'         AS title,
    '/a_panels/panel_editor_3.sql' AS link;
SELECT 
     '/c_workspaces/workspace_main_display_3.sql'             AS link,
    'Espaces de travail'           AS title;


SELECT 
    'button' AS component,
    'L'     AS size;
SELECT 
    '/c_workspaces/workforum_topic_form_3.sql?workspace_id='||$workspace_id    AS link,
    'green'                              AS color,
    TRUE                                 AS important,
    'Lancer une nouvelle discussion'     AS title,
    'arrows-random'                      AS icon;


-- Get the last inserted topic ID
SET topic_id = (SELECT MAX(topic_id) FROM forum_topics WHERE topic_name = :topic_name);

-- Display list of forum_topics
SELECT 'table' AS component, 
    'Forum forum_topics'   AS title, 
    JSON('{"name":"Discussion","tooltip":"Entrer dans a discussion","link":"/c_workspaces/workforum_message_display_4.sql?topic_id={id}","icon":"messages"}') as custom_actions,
    TRUE             AS sort, 
    TRUE             AS search;

SELECT       -- NOTE: the dots join values FROM the forum_topics and forum_messages tables
    t.topic_id       AS ID,
    t.topic_id       AS _sqlpage_id,
    t.topic_name     AS Topic,
    t.topic_category AS Categorie,
    to_char(m.created_at AT TIME ZONE 'Europe/Paris', 'YYYY-MM-DD HH24:MI')  AS Created_at,
    (SELECT username FROM users WHERE users.user_id =  t.topic_author_id)    AS Contributeur,
    '[Discussion](/c_workspaces/workforum_message_display_3.sql?topic_id='||t.topic_id||'&workspace_id='||$workspace_id||')'   AS View
FROM forum_topics AS t
LEFT JOIN (
    SELECT topic_id, MAX(created_at) AS created_at,  message_author_id  
    FROM forum_messages
    GROUP BY topic_id, message_author_id) AS m 
    ON t.topic_id = m.topic_id
WHERE t.topic_status !='archived' AND t.forum_type='forum_wkps' AND t.workspace_id=$workspace_id::INTEGER 
ORDER BY m.created_at DESC;