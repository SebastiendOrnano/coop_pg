SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SELECT 
    'breadcrumb' as component;
SELECT 
    'Home' as title,
    '/'    as link;
SELECT 
    'Gestion Superviseur'         as title,
    '/a_panels/panel_supervisor_4.sql' as link;
 SELECT 
    'Retour à la liste des projets'            as title,
    '/e_project/project_main_display_4.sql'     as link;   
 SELECT 
    'Retour au hub du projet'            as title,
    '/e_project/project_hub_display_4.sql?project_id='||$project_id     as link;
 SELECT 
    'Liste des discussion en cours'            as title,
    '/e_project_forum/project_forum_main_display_4.sql?project_id='||$project_id     as link;


-- Form for adding a new topic and initial message
SELECT 
    'form'  as component, 
    'Lancer une discussion'  as title,
    'Valider'                           as validate,
    'Clear'                              as reset,
    '/e_project_forum/project_forum_main_create_0.sql?project_id='||$project_id  as action;

SELECT 
    'Sujet'             as label,
    'project_forum_topic_name'        AS name,
    'text'              as type, 
    'Enter topic title' AS placeholder, 
    TRUE as required;

SELECT 
    'project_forum_topic_category'            as name,
    'Categorie'                 as label,
    'select'                    as type,
    TRUE                        as required,
    4                           AS width,
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
    'Votre message : ' AS value,
    'Vous pouvez rédifer en markdown !' as description,
    TRUE as required;
