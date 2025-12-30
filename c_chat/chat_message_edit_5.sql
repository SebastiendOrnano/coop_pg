SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_5.sql') AS properties;

SELECT 
    'form'                  AS component,
    'actualiser le message' AS validate,
    'clear'                 AS reset,
    '/c_chat/chat_message_update_0.sql?message_id='||$message_id AS action;

SELECT 
    'message_content'           AS name, 
    'textarea'                        AS type, 
    (SELECT message_content FROM forum_messages WHERE message_id=$message_id::INTEGER ) AS value,
    'Contenu de la contribution'    AS label,
    TRUE                               AS required;


SELECT 
    'message_content'  AS name, 
    'Contenu du message'  AS label,
    'textarea'       AS type, 
    'Your message' AS placeholder, 
    (SELECT message_content  FROM forum_messages WHERE message_id=$message_id::INTEGER ) AS value,
    TRUE AS required;

SELECT 
    'message_status'            AS name,
    'Statut de publication'    AS label,
    'select'                 AS type,
    (SELECT message_status FROM forum_messages WHERE  message_id=$message_id::INTEGER ) AS value,
    TRUE                     AS required,
    2                        AS width,
    'Choisir un statut dans la liste...'    AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='status';




