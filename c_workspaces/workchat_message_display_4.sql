SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SET workspace_id = select workspace_id FROM forum_topics WHERE topic_id=$topic_id::INTEGER;

SELECT
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion superviseur'         AS title,
    '/a_panels/panel_supervisor.sql' AS link;
SELECT 
     '/c_workspaces/workspace_main_display_4.sql'             AS link,
    'Espaces de travail'           AS title;
SELECT
    '/c_workspaces/workspace_hub_display_4.sql?workspace_id='||$workspace_id  AS link,
    'Hub du groupe de travail' AS title;
SELECT 
    'Liste des messages'            AS title,
    '/c_workspaces/workchat_display_4.sql?workspace_id='||$workspace_id  AS link;

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
        (SELECT to_char(created_at AT TIME ZONE 'Europe/Paris', 'YYYY-MM-DD HH24:MI') FROM forum_topics WHERE topic_id=$topic_id::INTEGER )  AS value; 

SELECT
    'text'             AS component,
    'forum_message_md' AS id,
    (SELECT m.message_content FROM forum_topics AS t 
    LEFT JOIN  (SELECT topic_id, message_content, message_rank FROM forum_messages)  AS m
    ON t.topic_id = m.topic_id AND message_rank='main'
    WHERE t.topic_id=$topic_id::INTEGER)
    AS contents_md; 


SET message_id_main = SELECT message_id FROM forum_messages WHERE topic_id = $topic_id::INTEGER AND message_rank = 'main';


SELECT 
    'table'                      AS component;
SELECT
    m.message_id                AS Id,
    CASE
        WHEN d.message_id IS NOT NULL  AND c.message_id IS NOT NULL
         THEN
            json_build_array(
                json_build_object(
                    'name', 'Doc',
                    'tooltip', 'Document en local',
                    'link', d.workdoc_url,
                    'icon', 'book'
                ),
                json_build_object(
                    'name', 'DocCloud',
                    'tooltip', 'Document en ligne',
                    'link', c.workdoc_cloud_url,
                    'icon', 'cloud-check'
                )
            )
        WHEN d.message_id IS NULL  AND c.message_id IS NOT NULL
        THEN
            json_build_array(
                json_build_object(
                    'name', 'Doc'
                ),
                json_build_object(
                    'name', 'DocCloud',
                    'tooltip', 'Document en ligne',
                    'link', c.workdoc_cloud_url,
                    'icon', 'cloud-check'
                )
            )
        WHEN d.message_id IS NOT NULL  AND c.message_id IS NULL
        THEN
            json_build_array(
                json_build_object(
                    'name', 'Doc',
                    'tooltip', 'Document en local',
                    'link', d.workdoc_url,
                    'icon', 'book'
                ),
                 json_build_object(
                    'name', 'DocCloud'
                )
            )
        ELSE
            json_build_array(
                json_build_object(
                    'name', 'Doc'
                ),
                json_build_object(
                    'name', 'DocCloud'
                )
            )
    END AS _sqlpage_actions 

FROM forum_messages AS m
LEFT JOIN (SELECT message_id, workdoc_title, workdoc_url, workdoc_id FROM workdocs) AS d
    ON d.message_id = m.message_id
LEFT JOIN (SELECT message_id, workdoc_cloud_title, workdoc_cloud_url, workdoc_cloud_id FROM workdocs_cloud) AS c
    ON c.message_id = m.message_id
WHERE m.topic_id = $topic_id::INTEGER
  AND m.message_rank = 'main'
  AND m.message_status = 'active'
ORDER BY created_at ASC;

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
    TRUE                         AS sort, 
    TRUE                         AS search;

SELECT
    m.message_id              AS Id,
    m.message_id              AS _sqlpage_id,
    to_char(m.created_at AT TIME ZONE 'Europe/Paris', 'YYYY-MM-DD HH24:MI') AS Posted_At,
    (SELECT users.username FROM users WHERE users.user_id = m.message_author_id) AS Author,
    m.message_content        AS Message,
    CASE
        WHEN d.message_id IS NOT NULL  AND c.message_id IS NOT NULL
         THEN
            json_build_array(
                json_build_object(
                    'name', 'Doc',
                    'tooltip', 'Document en local',
                    'link', d.workdoc_url,
                    'icon', 'book'
                ),
                json_build_object(
                    'name', 'DocCloud',
                    'tooltip', 'Document en ligne',
                    'link', c.workdoc_cloud_url,
                    'icon', 'cloud-check'
                )
            )
        WHEN d.message_id IS NULL  AND c.message_id IS NOT NULL
        THEN
            json_build_array(
                json_build_object(
                    'name', 'Doc'
                ),
                json_build_object(
                    'name', 'DocCloud',
                    'tooltip', 'Document en ligne',
                    'link', c.workdoc_cloud_url,
                    'icon', 'cloud-check'
                )
            )
        WHEN d.message_id IS NOT NULL  AND c.message_id IS NULL
        THEN
            json_build_array(
                json_build_object(
                    'name', 'Doc',
                    'tooltip', 'Document en local',
                    'link', d.workdoc_url,
                    'icon', 'book'
                ),
                 json_build_object(
                    'name', 'DocCloud'
                )
            )
        ELSE
            json_build_array(
                json_build_object(
                    'name', 'Doc'
                ),
                json_build_object(
                    'name', 'DocCloud'
                )
            )
    END AS _sqlpage_actions, 
    CASE
    WHEN 
    (SELECT u.username FROM users AS u  WHERE u.user_id = m.message_author_id)  = $username
    THEN 
          json_build_array(
                json_build_object(
                    'name', 'Edit',
                    'tooltip', 'Modifier le message',
                    'link', '/c_workspaces/workchat_message_edit_4.sql?message_id='||m.message_id,
                    'icon', 'edit'
                ),
                 json_build_object(
                    'name', 'Delete',
                    'tooltip', 'Supprimer le message',
                    'link', '/c_workspaces/workchat_message_delete_0.sql?message_id='||m.message_id,
                    'icon', 'trash'
                )
            )
        ELSE
            json_build_array(
                json_build_object(
                    'name', 'Edit'
                ),
                json_build_object(
                    'name', 'Delete'
                )
            )
    END AS _sqlpage_actions

FROM forum_messages AS m
LEFT JOIN (SELECT message_id, workdoc_url, workdoc_id FROM workdocs) AS d
    ON d.message_id = m.message_id
LEFT JOIN (SELECT message_id, workdoc_cloud_url, workdoc_cloud_id FROM workdocs_cloud) AS c
    ON c.message_id = m.message_id
WHERE m.topic_id = $topic_id::INTEGER
  AND m.message_rank <> 'main'
  AND m.message_status = 'active'
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


 SET  message_recipient_id = (SELECT topic_author_id FROM forum_topics WHERE topic_id=$topic_id::INTEGER) ;

-- Form for replying to the topic

SELECT 'form'      AS component,
    $closed_discussion2 AS validate,
    '/c_workspaces/workchat_message_create_0.sql?topic_id='||$topic_id AS action;

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
    'URL du document partagé sur le cloud' AS label;
