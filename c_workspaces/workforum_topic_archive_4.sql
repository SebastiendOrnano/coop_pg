SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT
    '/c_workspaces/workspace_hub_display_4.sql?workspace_id='||$workspace_id  AS link,
    'Retour hub du groupe de travail' AS title;
SELECT
    '/c_workspaces/workforum_topic_display_4.sql?workspace_id='||$workspace_id  AS link,
    'Retour listes des discussions' AS title;


SET user_id = (
    SELECT u.user_id  FROM users as u
    LEFT JOIN (SELECT session_id, user_id, session_token FROM sessions) as s
    ON s.user_id = u.user_id
    WHERE s.session_token = sqlpage.cookie('session_token')
);

-- Get the last inserted topic ID
SET topic_id = (SELECT MAX(topic_id) FROM forum_topics WHERE topic_name = :topic_name);

-- Display list of forum_topics
SELECT 'table' AS component, 
    'Forum forum_topics'   AS title, 
    'View'           AS markdown, 
    TRUE             AS sort;

SELECT       -- NOTE: the dots join values FROM the forum_topics and forum_messages tables
    t.topic_id       AS ID,
    t.topic_name     AS Topic,
    t.topic_category AS Categorie,
    m.created_at     AS Created_at,
    (SELECT username FROM users WHERE users.user_id =  t.topic_author_id)    AS Contributeur,
    '[Disclose](/c_workspaces/workforum_topic_disclose_0.sql?topic_id='||t.topic_id||'&workspace_id='||$workspace_id||')'   AS View
FROM forum_topics AS t
LEFT JOIN (
    SELECT topic_id, MAX(created_at) AS created_at,  message_author_id  
    FROM forum_messages
    GROUP BY topic_id, message_author_id ) AS m 
    ON t.topic_id = m.topic_id
WHERE t.topic_status ='archived' AND t.forum_type='forum_wkps' AND t.workspace_id=$workspace_id::INTEGER 
ORDER BY m.created_at DESC;