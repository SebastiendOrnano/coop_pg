SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SELECT
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion Superviseur'         AS title,
    '/a_panels/panel_supervisor_4.sql' AS link;
SELECT 
     '/c_workspaces/workspace_main_display_4.sql'             AS link,
    'Espaces de travail'           AS title;
SELECT 
    '/c_workspaces/workspace_hub_display_4.sql?workspace_id='||$workspace_id  AS link,
    'Espace du groupe de travail'                                      AS title;
SELECT 
    '/c_workspaces/workspace_participants_display_4.sql?workspace_id='||$workspace_id  AS link,
    'Retour membres du groupe de travail'                                      AS title;
SELECT 
    '/c_workspaces/workchat_display_4.sql?workspace_id='||$workspace_id  AS link,
    'Discussions en cours (chat)'                                      AS title;

SELECT 
    'divider'              AS component,
    'Liste des discussions en cours' AS contents,
    'left'                 AS position,
    'black'                AS color;

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
    WHEN m.message_author_id =$user_id::INTEGER THEN 'me'
    ELSE (SELECT username||'   ('||user_id||')' FROM users WHERE user_id=m.message_author_id) 
    END       AS auteur,
    CASE
     WHEN m.message_recipient_id =$user_id::INTEGER THEN ''
    ELSE (SELECT username||'   ('||user_id||')' FROM users WHERE user_id=m.message_recipient_id)  
    END    AS destinataire,
    '[Discussion](/c_workspaces/workchat_message_display_4.sql?topic_id='||t.topic_id||'&workspace_id='||$workspace_id||')&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Open](/c_workspaces/workchat_open_0.sql?topic_id='||t.topic_id||'&workspace_id='||$workspace_id||')'    AS View
FROM forum_topics AS t
LEFT JOIN 
(SELECT topic_id, MAX(created_at) AS created_at,  message_author_id, message_recipient_id FROM forum_messages GROUP BY topic_id, message_recipient_id, message_author_id) AS m 
ON t.topic_id = m.topic_id
WHERE t.topic_status ='closed' AND t.forum_type='chat_wksp' AND t.workspace_id=$workspace_id::INTEGER AND (m.message_author_id = $user_id::INTEGER OR m.message_recipient_id = $user_id::INTEGER)
AND t.workspace_id=$workspace_id::INTEGER
ORDER BY m.created_at DESC;