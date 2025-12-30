SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_3.sql') AS properties;

set project_forum_topic_id= SELECT project_forum_topic_id FROM project_forum_messages WHERE project_forum_message_id=$project_forum_message_id::INTEGER;
set project_id = SELECT project_id FROM project_forum_topics WHERE project_forum_topic_id=$project_forum_topic_id::INTEGER;


SELECT 
    'breadcrumb' as component;
SELECT 
    'Home' as title,
    '/'    as link;
SELECT 
    'Gestion éditeur'         as title,
    '/a_panels/panel_editor_3.sql' as link;
 SELECT 
    'Projets'            as title,
    '/e_project/project_main_display_3.sql'     as link;   
 SELECT 
    'Hub du projet'            as title,
    '/e_project/project_hub_display_3.sql?project_id='||$project_id     as link;
 SELECT 
    'Liste des discussion en cours'            as title,
    '/e_project_forum/project_forum_main_display_3.sql?project_id='||$project_id     as link;

SELECT 
    'form'                  AS component,
    'actualiser le message' as validate,
    'clear'                 as reset,
    '/e_project_forum/project_forum_message_update_0.sql?project_forum_message_id='||$project_forum_message_id AS action;

SELECT 
    'project_forum_message_status'            as name,
    'Statut de publication'    as label,
    'hidden'                 as type,
    (SELECT project_forum_message_status FROM project_forum_messages WHERE  project_forum_message_id=$project_forum_message_id::INTEGER ) as value,
    TRUE                     as required,
    2                        AS width,
    'Choisir un statut dans la liste...'    as empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='status';

SELECT 
    'project_forum_message_content'  AS name, 
    'Contenu du message'  as label,
    'textarea'       as type, 
    (SELECT project_forum_message_content  FROM project_forum_messages WHERE project_forum_message_id=$project_forum_message_id::INTEGER ) as value,
    TRUE as required;

SELECT 
    'text' AS type, 
    'project_doc_title' AS name,
    (SELECT project_doc_title FROM project_docs  WHERE project_forum_message_id=$project_forum_message_id::INTEGER AND project_doc_local_cloud='local') as value,
    'titre du document' AS label;

SELECT 
    'file' AS type, 
    'project_doc_url' AS name,
    'Nouveau Document local à partager' AS label,
    'size max : 5 MB' AS description,
    '*'  AS accept;

SELECT 
    'text' AS type, 
    'project_doc_title_link' AS name,
    (SELECT project_doc_title_link FROM project_docs WHERE project_forum_message_id=$project_forum_message_id::INTEGER AND project_doc_local_cloud='cloud') as value,
    'titre du lien' AS label;

SELECT 
    'text' AS type, 
    'project_doc_cloud_url' AS name,
    (SELECT project_doc_cloud_url FROM project_docs WHERE project_forum_message_id=$project_forum_message_id::INTEGER AND project_doc_local_cloud='cloud') as value,
    'URL du document partagé sur le cloud' AS label;




