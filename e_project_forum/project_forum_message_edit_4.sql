SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

set project_forum_topic_id= SELECT project_forum_topic_id FROM project_forum_messages WHERE project_forum_message_id=$project_forum_message_id::INTEGER;
set project_id = SELECT project_id FROM project_forum_topics WHERE project_forum_topic_id=$project_forum_topic_id::INTEGER;


SELECT 
    'breadcrumb' as component;
SELECT 
    'Home' as title,
    '/'    as link;
SELECT 
    'Liste des discussions'            as title,
    '/e_project_forum/project_forum_main_display_4.sql?project_id='||$project_id   as link;
SELECT 
    'Discussion en cours'            as title,
    '/e_project_forum/project_forum_message_display_4.sql?project_forum_topic_id='||$project_forum_topic_id as link;

SELECT 
    'form'                  AS component,
    'actualiser le message' as validate,
    'clear'                 as reset,
    '/e_project_forum/project_forum_message_update_0.sql?project_forum_message_id='||$project_forum_message_id AS action;

SELECT 
    'project_forum_message_content'           AS name, 
    'textarea'                        as type, 
    (SELECT project_forum_message_content FROM project_forum_messages WHERE project_forum_message_id=$project_forum_message_id::INTEGER ) as value,
    'Contenu de la contribution'    as label,
    TRUE                               as required;


SELECT 
    'project_forum_message_content'  AS name, 
    'Contenu du message'  as label,
    'textarea'       as type, 
    'Your message' AS placeholder, 
    (SELECT project_forum_message_content  FROM project_forum_messages WHERE project_forum_message_id=$project_forum_message_id::INTEGER ) as value,
    TRUE as required;

SELECT 
    'project_forum_message_status'            as name,
    'Statut de publication'    as label,
    'select'                 as type,
    (SELECT project_forum_message_status FROM project_forum_messages WHERE  project_forum_message_id=$project_forum_message_id::INTEGER ) as value,
    TRUE                     as required,
    2                        AS width,
    'Choisir un statut dans la liste...'    as empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='status';





