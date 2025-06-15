SET  topic_status= SELECT topic_status FROM  forum_topics WHERE topic_id = $topic_id::INTEGER  ;

SELECT 'redirect' AS component,
'/c_debug/debug_message_close_display_5.sql?topic_id='||$topic_id AS link 
WHERE $topic_status='closed';

SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_5.sql') AS properties;

SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Liste des discussions'            AS title,
    '/c_debug/debug_main_display_5.sql'   AS link;

SELECT 
    'divider'              AS component,
    'Message initial'             AS contents,
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
    (SELECT username FROM users AS u 
    INNER JOIN forum_topics AS f 
    ON u.user_id = f.topic_author_id 
    WHERE f.topic_id=$topic_id::INTEGER ) AS value; 

SELECT
    'created_at' AS name,
    'le : ' AS label,
    2 AS width,
    (SELECT created_at FROM forum_topics WHERE topic_id=$topic_id::INTEGER )  AS value;

SELECT
    'message_content' AS name,
    'textarea'         AS type,
    (SELECT message_content FROM forum_messages WHERE message_rank='main' AND topic_id=$topic_id::INTEGER )  AS value;

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
    message_id             AS Id,
    created_at             AS Created_at,
    (SELECT users.username FROM users WHERE users.user_id = message_author_id )  AS Author,
    message_status         AS Statut,
    message_content        AS Message,
'[Edit](/c_debug/debug_message_edit_5.sql?message_id='||message_id||')&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
[Delete](/c_debug/debug_message_delete_0.sql?message_id='||message_id||')' AS View  
FROM forum_messages
WHERE topic_id = $topic_id::INTEGER  AND message_rank!='main' AND message_status='active'
ORDER BY created_at ASC;

SELECT 
    'divider'              AS component,
    'Votre contribution'   AS contents,
    'left'                 AS position,  
    4                      AS size,
    'green'                AS color;

-- Form for replying to the topic
SELECT 'form'      AS component,
 'Envoyer'         AS validate,
 'Clear'           AS reset,
 '/c_debug/debug_message_create_0.sql?topic_id='||$topic_id AS action;

SELECT 
'message_content'                  AS name, 
'textarea'                         AS type, 
'Votre contribution'               AS label,
'Vous pouvez rédiger en markdown'  AS description,
TRUE                               AS required;