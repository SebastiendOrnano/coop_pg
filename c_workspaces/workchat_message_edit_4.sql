SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SET topic_id = SELECT topic_id FROM forum_messages WHERE message_id = $message_id::INTEGER;
SET workspace_id = SELECT workspace_id FROM forum_topics WHERE topic_id = $topic_id::INTEGER;




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
    'Retour espaces de travail'                               AS title;
SELECT 
    '/c_workspaces/workspace_hub_display_4.sql?workspace_id='||$workspace_id  AS link,
    'Retour espace du groupe de travail'                                      AS title;
SELECT 
    '/c_workspaces/workchat_message_display_4.sql?topic_id='||$topic_id||'&workspace_id='||$workspace_id  AS link,
    'Retour au chat'                                      AS title;

SET message_recipient_id = SELECT message_recipient_id FROM forum_messages WHERE message_id = $message_id::INTEGER;

-- Form for adding a new topic and initial message
SELECT 
    'form'  AS component, 
    'Actualiser un post de chat'  AS title,
    'Valider'                           AS validate,
    'Clear'                              AS reset,
    '/c_workspaces/workchat_update_0.sql?message_id='||$message_id||'&workspace_id='||$workspace_id  AS action;

SELECT 
   'username' AS name,
    'Destinataire' AS label,
    'text' AS type,
    6 AS width,
    TRUE AS readonly,
    (SELECT username FROM users WHERE user_id = $message_recipient_id::INTEGER ) AS value;

SELECT 
    'Sujet'             AS label,
    'topic_name'        AS name,
    'text'              AS type, 
    t.topic_name        AS value,
    TRUE                AS readonly
    FROM forum_topics AS t 
    LEFT JOIN 
    (SELECT message_id, topic_id FROM forum_messages) AS m 
    ON t.topic_id=m.topic_id 
    WHERE m.message_id=$message_id::INTEGER;

SELECT 
    'message_content'  AS name, 
    'Votre message'  AS label,
    'textarea'       AS type, 
    'Your message' AS placeholder,
    /*TRUE AS required,*/
    (SELECT message_content FROM forum_messages WHERE message_id=$message_id::INTEGER ) AS value,
    'Vous pouvez rédifer en markdown !' AS description;
  ;
