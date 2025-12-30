SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SET topic_id = (SELECT MAX(topic_id) FROM forum_topics WHERE topic_name = :topic_name);

SET user_id = (
    SELECT users.user_id FROM users
    INNER JOIN sessions ON users.user_id = sessions.user_id
    WHERE sessions.session_token = sqlpage.cookie('session_token')
);


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
    'Membres du groupe de travail'                                      AS title;

SELECT 
    'datagrid'              AS component,
    'panel_hub_workspace_display' AS id,
    'Discussions privées en cours' AS title;
SELECT 
    '/c_workspaces/workchat_form2_4.sql?workspace_id='||$workspace_id    AS link,
    'Création d''une discussion'                       AS description,
    'calendar-time'                                      AS icon,
    'yellow'                                        AS color;

SELECT 
    '/c_workspaces/workchat_archive_4.sql?workspace_id='||$workspace_id    AS link,
    'Discussions archivées'                       AS description,
    'archive'                                      AS icon,
    'green'                                     AS color;


-- Display list of forum_topics
SELECT 'table' AS component, 
    'Forum forum_topics'   AS title, 
    JSON('{"name":"Discussion","tooltip":"Entrer dans a discussion","link":"/c_workspaces/workchat_message_display_4.sql?topic_id={id}","icon":"messages"}') as custom_actions,
    JSON('{"name":"Close","tooltip":"Fermer la discussion","link":"/c_workspaces/workchat_close_0.sql?topic_id={id}","icon":"lock"}') as custom_actions,
    TRUE             AS sort, 
    TRUE             AS search;

SELECT       -- NOTE: the dots join values FROM the forum_topics and forum_messages tables
    t.topic_id                 AS ID,
    t.topic_id                 AS _sqlpage_id,
    t.topic_name               AS Topic,
    t.topic_category           AS Categorie,
    to_char(t.created_at AT TIME ZONE 'Europe/Paris', 'YYYY-MM-DD HH24:MI')  AS Created_at,
    CASE
    WHEN m.message_author_id =$user_id::INTEGER THEN 'me'
    ELSE (SELECT username||'   ('||user_id||')' FROM users WHERE user_id=m.message_author_id) 
    END       AS auteur,
    CASE
     WHEN m.message_recipient_id =$user_id::INTEGER THEN 'me'
    ELSE (SELECT username||'   ('||user_id||')' FROM users WHERE user_id=m.message_recipient_id)  
    END    AS destinataire
FROM forum_topics AS t
LEFT JOIN 
(SELECT topic_id,  created_at, message_rank,  message_author_id, message_recipient_id FROM forum_messages GROUP BY topic_id, created_at, message_recipient_id, message_author_id, message_rank) AS m 
ON t.topic_id = m.topic_id
WHERE t.topic_status ='active' AND m.message_rank = 'main'AND t.forum_type='chat_wksp' AND t.workspace_id=$workspace_id::INTEGER AND (m.message_author_id = $user_id::INTEGER OR m.message_recipient_id = $user_id::INTEGER)
AND t.workspace_id=$workspace_id::INTEGER
ORDER BY m.created_at DESC;