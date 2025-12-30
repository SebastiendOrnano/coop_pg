SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_1.sql') AS properties;

SELECT 
    'button' AS component,
    'L'     AS size;
SELECT 
    '/c_chat/chat_main_form_1.sql'     AS link,
    'green'                              AS color,
    TRUE                                 AS important,
    'Lancer une nouvelle discussion'     AS title,
    'arrows-random'                      AS icon;


-- Get the last inserted topic ID
SET topic_id = (SELECT MAX(topic_id) FROM forum_topics WHERE topic_name = :topic_name);

SET user_id = (
    SELECT users.user_id FROM users
    INNER JOIN sessions ON users.user_id = sessions.user_id
    WHERE sessions.session_token = sqlpage.cookie('session_token')
);

-- Display list of forum_topics
SELECT 'table' AS component, 
    'Forum forum_topics'   AS title, 
    'View'           AS markdown, 
    TRUE             AS sort, 
    TRUE             AS search;

SELECT       -- NOTE: the dots join values FROM the forum_topics and forum_messages tables
    t.topic_id                 AS ID,
    t.topic_name               AS Topic,
    t.topic_category           AS Categorie,
    m.created_at               AS Created_at,
    CASE
    WHEN m.message_author_id =$user_id::INTEGER THEN ''
    ELSE (SELECT username||'   ('||user_id||')' FROM users WHERE user_id=m.message_author_id) 
    END       AS auteur,
    CASE
     WHEN m.message_recipient_id =$user_id::INTEGER THEN ''
    ELSE (SELECT username||'   ('||user_id||')' FROM users WHERE user_id=m.message_recipient_id)  
    END    AS destinataire,
    '[Discussion](/c_chat/chat_message_display_1.sql?topic_id=' || t.topic_id || ')'    AS View
FROM forum_topics AS t
LEFT JOIN (
    SELECT topic_id, MAX(created_at) AS created_at,  message_author_id, message_recipient_id  
    FROM forum_messages
    GROUP BY topic_id, message_author_id, message_recipient_id ) AS m 
    ON t.topic_id = m.topic_id
WHERE t.topic_status !='archived' AND t.forum_type='chat' AND (m.message_author_id =$user_id::INTEGER OR m.message_recipient_id =$user_id::INTEGER)
/*AND t.chat_group=$user_group */
ORDER BY m.created_at DESC;