SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_1.sql') AS properties;

SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Liste des discussions'            AS title,
   '/c_chat/chat_main_display_1.sql'   AS link;

-- Form for adding a new topic and initial message
SELECT 
    'form'  AS component, 
    'Lancer une discussion'  AS title,
    'Valider'                           AS validate,
    'Clear'                              AS reset,
    '/c_chat/chat_main_create_0.sql'  AS action;

SELECT 
   'message_recipient_id' AS name,
    'Destinataire' AS label,
    'select' AS type,
    6 AS width,
    TRUE AS searchable,
    TRUE AS required,
    'Saisissez quelques lettres du nom que vous cherchez ou choississez dans la liste' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label', username || '   (' || user_id|| ')   ' || user_last_name, 'value', user_id)) AS options
    FROM (
    SELECT username, user_first_name, user_last_name, user_id
    FROM users
    ORDER BY user_last_name ASC, user_first_name ASC
    );

SELECT 
    'Sujet'             AS label,
    'topic_name'        AS name,
    'text'              AS type, 
    'Enter topic title' AS placeholder, 
    TRUE AS required;

SELECT 
    'message_content'  AS name, 
    'Votre message'  AS label,
    'textarea'       AS type, 
    'Your message' AS placeholder,
    'Vous pouvez rédifer en markdown !' AS description,
    TRUE AS required;
