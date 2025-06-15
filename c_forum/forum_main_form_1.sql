SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_1.sql') AS properties;


-- Form for adding a new topic and initial message
SELECT 
    'form'  AS component, 
    'Lancer une discussion'  AS title,
    'Valider'                           AS validate,
    'Clear'                              AS reset,
    '/c_forum/forum_main_create_0.sql'  AS action;

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
    'Your message' AS placeholder,
    'Vous pouvez rédifer en markdown !' AS description,
    TRUE AS required;
