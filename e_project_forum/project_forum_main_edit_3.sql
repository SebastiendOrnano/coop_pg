SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_3.sql') AS properties;


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


-- Form for adding a new topic and initial message
SELECT 
    'form'  as component, 
    'Actualiser le sujet initial d''une discussion'  as title,
    'Valider'                           as validate,
    'Clear'                              as reset,
    '/e_project_forum/project_forum_main_update_0.sql?project_forum_topic_id='||$project_forum_topic_id as action;

SELECT 
    'Sujet'             as label,
    'project_forum_topic_name'        AS name,
    'text'              as type, 
    'Enter topic title' AS placeholder, 
    (SELECT project_forum_topic_name FROM project_forum_topics WHERE project_forum_topic_id=$project_forum_topic_id::INTEGER ) as value,
    TRUE as required;

SELECT 
    'project_forum_topic_status'            as name,
    'Statut'                 as label,
    'select'                    as type,
    TRUE                        as required,
    4                           AS width,
    (SELECT project_forum_topic_status FROM project_forum_topics WHERE project_forum_topic_id=$project_forum_topic_id::INTEGER ) as value,
    'Choisir un statut dans la liste...'    as empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='status';



SELECT 
    'project_forum_topic_category'            as name,
    'Categorie'                 as label,
    'select'                    as type,
    TRUE                        as required,
    4                           AS width,
    (SELECT project_forum_topic_category FROM project_forum_topics WHERE project_forum_topic_id=$project_forum_topic_id::INTEGER ) as value,
    'Choisir une catégorie dans la liste...'    as empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='topic_category';


SELECT 
    'project_forum_message_content'  AS name, 
    'Votre message'  as label,
    'textarea'       as type, 
    (SELECT project_forum_message_content FROM project_forum_messages WHERE project_forum_topic_id=$project_forum_topic_id::INTEGER and project_forum_message_rank='main') as value,
    'Vous pouvez rédiger en markdown !' as description,
    TRUE as required;
