SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SET user_role = (
    SELECT user_role FROM users
    INNER JOIN sessions ON users.user_id = sessions.user_id
    WHERE sessions.session_token = sqlpage.cookie('session_token')
); 

SET FROM_id = (
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
    '/c_workspaces/workspace_hub_display_4.sql?workspace_id='||$workspace_id  AS link,
    'Retour hub du groupe de travail' AS title;
SELECT 
    'Retour à la liste des discussions'            AS title,
    '/c_workspaces/workforum_topic_display_4.sql?workspace_id='||$workspace_id  AS link;

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
    (SELECT username FROM users AS u INNER JOIN forum_topics AS f 
    ON u.user_id = f.topic_author_id 
    WHERE f.topic_id=$topic_id::INTEGER ) AS value; 

SELECT
    'created_at' AS name,
    'le : ' AS label,
    2 AS width,
    (SELECT created_at FROM forum_topics WHERE topic_id=$topic_id::INTEGER )  AS value;

SELECT
    'text'             AS component,
    'forum_message_md' AS id,
    (SELECT m.message_content FROM forum_topics AS t 
    LEFT JOIN  (SELECT topic_id, message_content, message_rank FROM forum_messages)  AS m
    ON t.topic_id = m.topic_id AND message_rank='main'
    WHERE t.topic_id=$topic_id::INTEGER)
    AS contents_md; 

SET message_id = (SELECT MAX(message_id) FROM forum_messages WHERE topic_id = $topic_id::INTEGER);

SET doc_link = 
CASE
WHEN (SELECT workdoc_url FROM workdocs WHERE message_id=$message_id::INTEGER) IS NOT NULL 
THEN  concat('http://localhost:8080/', (SELECT workdoc_url FROM workdocs WHERE message_id=$message_id::INTEGER ))
ELSE ''
END;

SET doc_title = 
CASE WHEN (SELECT workdoc_url FROM workdocs WHERE message_id=$message_id::INTEGER) IS NOT NULL
THEN 'Télécharger le document attaché' 
ELSE 'Pas de fichier attaché'
END;

SET doc_icon = 
CASE WHEN (SELECT workdoc_url FROM workdocs WHERE message_id=$message_id::INTEGER) IS NOT NULL 
THEN 'download'
ELSE ''
END;

SET doc_color = 
CASE WHEN (SELECT workdoc_url FROM workdocs WHERE message_id=$message_id::INTEGER) IS NOT NULL
THEN 'green'
ELSE 'red'
END;

SELECT 
    'button' AS component;
SELECT 
    $doc_link     AS link,
    $doc_icon AS icon,
    $doc_color  AS color,
    $doc_title AS title,
    'Download' AS tooltip;

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
    TRUE                         AS sort, 
    TRUE                         AS search;

SELECT
    m.message_id              AS Id,
    m.created_at             AS Posted_At,
    (SELECT users.username FROM users WHERE users.user_id = m.message_author_id )  AS Author,
    m.message_content        AS Message,
    '[Doc]('||d.workdoc_url||')' AS View   
FROM forum_messages AS m
LEFT JOIN (
    SELECT message_id, workdoc_url 
    FROM workdocs ) AS d
    ON d.message_id = m.message_id
    WHERE m.topic_id=$topic_id::INTEGER
ORDER BY created_at ASC;

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


-- Form for replying to the topic

SELECT 'form'      AS component,
 $closed_discussion2 AS validate,
 '/c_workspaces/workforum_message_create_0.sql?topic_id='||$topic_id||'&workspace_id='||$workspace_id::INTEGER AS action;

SELECT 
'message_content'                  AS name, 
$closed_discussion3                AS type, 
'Votre réponse'                    AS label,
'vous pouvez rédiger en markdown'  AS description,
'Votre réponse :'                  AS value,
TRUE                               AS required;

SELECT 
    'file' AS type, 
    'workdoc_url' AS name,
    'Document à partager' AS label,
    'size max : 5 MB' AS description,
    '*'  AS accept;
