SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion Superviseur'         AS title,
    '/a_panels/panel_supervisor_4.sql' AS link;
SELECT 
    'Retour à la liste des projets'            AS title,
    '/e_project/project_main_display_4.sql'     AS link;
SELECT 
    'Retour au hub du projet'            AS title,
    '/e_project/project_hub_display_4.sql?project_id='||$project_id     AS link; 
SELECT 
    'Retour à la liste des documents'            AS title,
    '/e_project/project_main_display_4.sql?project_id='||$project_id     AS link; 



SELECT 
    'alert'                     AS component,
    TRUE AS important,
    'Les modifications dans le formulaire seront appliquées à tous les documents sélectionnées !' AS description,
    'alert-triangle'            AS icon,
      TRUE                       AS dismissible,
    'yellow'                    AS color;

SELECT 
    'form' AS component,
    'Actualiser les métadonnées d''une série de documents' AS title,
    'Actualiser' AS validate,
    'Clear' AS reset,
    '/e_project_docs/project_doc_select_update_0.sql?project_id='||$project_id AS action

SELECT 
    'project_doc_selected' AS name,
    'hidden' AS type,
     true AS value,
    'project_doc_selected' AS label;

SELECT 
    'project_doc_author' AS name,
    'text' AS type,
    'Auteur(s)' AS label,
    6 AS width;

SELECT 
    'project_doc_keywords' AS name,
    'text' AS type,
    'Mots clés' AS label,
    'Séparez les mots par une virgule' AS description,
    6 AS width;

 SELECT 
    'project_doc_date_publication' AS name,
    'Date de publication' AS label,
    'date'       AS type, 
    3 AS width,
   (SELECT regex_value FROM regex WHERE regex_name='date')         AS pattern,
   (SELECT regex_description FROM regex WHERE regex_name='date')          AS description;

 SELECT 
    'project_doc_date_period' AS name,
    'Période concernée' AS label,
    'text'       AS type,
    2 AS width,
   (SELECT regex_value FROM regex WHERE regex_name='year')         AS pattern,
   (SELECT regex_description FROM regex WHERE regex_name='year')          AS description;

 SELECT 
    'project_doc_lang'        AS name,
    'Langue'               AS label,
    'select'                AS type,
    2                       AS width,
    'Choisir une langue...' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='lang';
   
SELECT 
    'project_doc_category'        AS name,
    'Catégorie'                 AS label,
    'select'                 AS type,
    3                       AS width,
    'Choisir une categorie...' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='doc_category';

SELECT 
    'project_doc_type'        AS name,
    'Type de document'   AS label,
    'select'                  AS type,
    3                         AS width,
    'Choisir un type...' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='doc_type';

SELECT 
    'project_doc_status'        AS name,
    'Statut d''édition'      AS label,
    'select'                 AS type,
    3                        AS width,
    'Choisir un statut...' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='status_publication';




