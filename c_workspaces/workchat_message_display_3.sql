SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_3.sql') AS properties;

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
    '/c_workspaces/workspace_hub_display_3.sql?workspace_id='||$workspace_id  AS link,
    'Retour hub du groupe de travail' AS title;
SELECT 
    'Retour liste messages'            AS title,
    '/c_workspaces/workchat_display_3.sql?workspace_id='||$workspace_id  AS link;

-- Display forum_messages for the selected topic

SELECT 
    'divider'              AS component,
    'Message initial'      AS contents,
    'left'                 AS position,  
    4                      AS size,
    'black'                AS color;

SELECT
    'form' AS component,
    '' AS validate;

SELECT
    'topic_name' AS name,
    'Titre du message initial' AS label,
     7 AS width,

    (SELECT topic_name FROM forum_topics WHERE topic_id=$topic_id::INTEGER )  AS value;

SELECT
    'topic_author' AS name,
    'Discussion lancée par : ' AS label,
    3 AS width,
    (SELECT username FROM users AS u INNER JOIN forum_topics AS f ON u.user_id = f.topic_author_id WHERE f.topic_id=$topic_id::INTEGER ) AS value; 

SELECT
    'created_at' AS name,
    'le : ' AS label,
    2 AS width,
    (SELECT created_at FROM forum_topics AS t 
    WHERE t.topic_id=$topic_id::INTEGER AND t.workspace_id=$workspace_id::INTEGER)
    AS value; 

SELECT
    'text'             AS component,
    'chat_message_md' AS id,
    (SELECT m.message_content FROM forum_topics AS t 
    LEFT JOIN  (SELECT topic_id, message_content, message_rank  FROM forum_messages)  AS m
    ON t.topic_id = m.topic_id
    WHERE t.topic_id=$topic_id::INTEGER  AND t.workspace_id=$workspace_id::INTEGER AND m.message_rank='main')
    AS contents_md; 


SET username = (
    SELECT users.username FROM users
    INNER JOIN sessions ON users.user_id = sessions.user_id
    WHERE sessions.session_token = sqlpage.cookie('session_token')
); 

SELECT
    'divider'              AS component,
    'Réponses'             AS contents,
    'left'                 AS position,  
    4                      AS size,
    'black'                AS color;

SELECT 
    'table'                      AS component, 
    'Message'                    AS markdown,
    'View'                       AS markdown,
    'Doc'                        AS markdown,
    'DocCloud'                   AS markdown,
    TRUE                         AS sort;

SELECT
    m.message_id             as ID,
    m.created_at             AS Posted_At,
    (SELECT u.username FROM users as u  WHERE u.user_id = m.message_author_id )  AS Author,
    m. message_content        AS Message,
    '[DOC]('||(SELECT workdoc_url FROM workdocs as d WHERE d.message_id=m.message_id::INTEGER)||')'    AS Doc,
    '[DOC_cloud]('||(SELECT workdoc_cloud_url FROM workdocs_cloud as c WHERE c.message_id=m.message_id::INTEGER)||')'    AS DocCloud,
    CASE
    WHEN (SELECT u.username FROM users AS u  WHERE u.user_id = m.message_author_id)  = $username
    THEN (SELECT '[Edit](/c_workspaces/workchat_message_edit_3.sql?message_id='||m.message_id||') &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
[Delete](/c_workspaces/workchat_message_delete_0.sql?message_id='||m.message_id||')') 
    ELSE ''
    END AS View   
FROM forum_messages AS m
WHERE m.topic_id = $topic_id::INTEGER AND m.message_rank!='main'
ORDER BY m.created_at ASC;

SET topic_status= SELECT topic_status FROM  forum_topics WHERE topic_id = $topic_id::INTEGER ;

SET closed_discussion1 =
CASE
WHEN $topic_status='closed'  THEN 'Cette discussion est clôturée.'
ELSE 'Votre réponse'
END;

SET closed_discussion2 =
CASE
WHEN $topic_status='closed'  THEN ''
ELSE 'Envoyer'
END;

SET closed_discussion3 =
CASE
WHEN $topic_status='closed'  THEN 'hidden'
ELSE 'textarea'
END;

SELECT
    'divider'              AS component,
    $closed_discussion1    AS contents,
    'left'                 AS position,  
    4                      AS size,
    'green'                AS color;


 SET  message_recipient_id = (SELECT topic_author_id FROM forum_topics WHERE topic_id=$topic_id::INTEGER) ;

-- Form for replying to the topic

SELECT 'form'      AS component,
    $closed_discussion2 AS validate,
    '/c_workspaces/workchat_message_create_0.sql?topic_id='||$topic_id||'&workspace_id='||$workspace_id AS action;

SELECT 
    'message_content'                  AS name, 
    $closed_discussion3                AS type, 
    'Votre réponse'                    AS label,
    /*TRUE                               AS required,*/
    'vous pouvez rédiger en markdown'  AS description;

SELECT 
    'file' AS type, 
    'workdoc_url' AS name,
    'Document à partager sur le serveur local' AS label,
    'size max : 5 MB' AS description,
    '*'  AS accept;

SELECT 
    'text' AS type, 
    'workdoc_cloud_url' AS name,
    'Document en ligne à partager' AS label,
    'size max : 5 MB' AS description,
    '*'  AS accept;

