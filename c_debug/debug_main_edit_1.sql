SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_1.sql') AS properties;


-- Form for adding a new topic and initial message
SELECT 
    'form'  AS component, 
    'FORUM : actualiser une discussion'          AS title,
    'Actualiser le sujet initial d''une discussion'                           AS validate,
    'Clear'                              AS reset,
    '/c_debug/debug_main_update_0.sql?topic_id='||$topic_id  AS action;

SELECT 
    'Sujet'             AS label,
    'topic_name'        AS name,
    'text'              AS type, 
    (SELECT topic_name FROM forum_topics WHERE topic_id=$topic_id::INTEGER ) AS value,
    'Enter topic title' AS placeholder, 
    TRUE AS readonly;

SELECT 
    'topic_status'                          AS name,
    'Statut de publication'                 AS label,
    'select'                                AS type,
    (SELECT topic_status FROM forum_topics WHERE topic_id=$topic_id::INTEGER ) AS value,
    TRUE                     AS required,
    2                        AS width,
    'Choisir un statut dans la liste...'    AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='status';


SELECT 
    'topic_category'            AS name,
    'Categorie'                 AS label,
    'select'                 AS type,
    (SELECT  topic_category FROM forum_topics WHERE topic_id=$topic_id::INTEGER ) AS value,
    TRUE                     AS required,
    2                        AS width,
    'Choisir une catégorie dans la liste...'    AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name="topic_category";


SELECT 
    'message_content'  AS name, 
    'Contenu du  message'  AS label,
    'textarea'       AS type, 
    'Your message' AS placeholder, 
    (SELECT message_content  FROM forum_messages WHERE topic_id=$topic_id::INTEGER ) AS value,
    TRUE AS required;




