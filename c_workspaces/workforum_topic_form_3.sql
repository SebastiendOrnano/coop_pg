SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_3.sql') AS properties;

SELECT
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion éditeur'         AS title,
    '/a_panels/panel_editor_3.sql' AS link;
SELECT 
     '/c_workspaces/workspace_main_display_3.sql'             AS link,
    'Espaces de travail'           AS title;
SELECT 
    '/c_workspaces/workspace_hub_display_3.sql?workspace_id='||$workspace_id  AS link,
    'Espace du groupe de travail'                                      AS title;

-- Form for adding a new topic and initial message
SELECT 
    'form'  AS component, 
    'Lancer une discussion'  AS title,
    'Valider'                           AS validate,
    'Clear'                              AS reset,
    '/c_workspaces/workforum_topic_create_0.sql?workspace_id='||$workspace_id  AS action;

SELECT 
    'Sujet'             AS label,
    'topic_name'        AS name,
    'text'              AS type, 
    'Enter topic title' AS placeholder, 
    TRUE AS required;

SELECT 
    'topic_category'            AS name,
    'Categorie'                 AS label,
    'select'                    AS type,
    TRUE                        AS required,
    4                           AS width,
    'Choisir une catégorie dans la liste...'    AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='topic_category';

SELECT 
    'message_content'  AS name, 
    'Votre message'  AS label,
    'textarea'       AS type, 
    'Your message :' AS value,
    'Vous pouvez rédifer en markdown !' AS description,
    TRUE AS required;

SELECT 
    'file' AS type, 
    'workdoc_url' AS name,
    'Document à partager' AS label,
    'size max : 5 MB' AS description,
    '*'  AS accept;
