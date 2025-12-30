SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT
    '/e_project_docs/project_hub_display_4.sql?project_id='||$project_id  AS link,
    'Retour hub du groupe de travail' AS title;
SELECT
    '/e_project_docs/project_hub_display_4.sql?project_id='||$project_id  AS link,
    'Retour hub du groupe de travail' AS title;
SELECT 
    'Gestion des documents du projet'            AS title,
    '/e_project_docs/project_doc_display_4.sql?project_id='||$project_id  AS link;

SELECT 
    'form' AS component,
    'Créer un document' AS title,
    'Créer' AS validate,
    'Clear' AS reset,
    '/e_project_docs/project_doc_cloud_create_0.sql?project_id='||$project_id AS action;

SELECT
    'project_doc_title' AS name,
    'text' AS type,  
    'Titre' AS label,
    'Choisissez un titre explicite pour faciliter les recherches' AS description,
    'Rapport d''activité 2024' AS placeholder,
    TRUE AS required,
    12 AS width;

SELECT 
    'text' AS type, 
    'project_doc_cloud_url' AS name,
    'URL du document partagé sur le cloud' AS label,
    TRUE       AS required;

SELECT 
    'project_doc_summary' AS name,
    'textarea' AS type,
    'Résumé' AS label,
    12 AS width;

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
    'project_doc_cloud_format'        AS name,
    'Format'                 AS label,
    'select'                 AS type,
    2                       AS width,
    'Choisir un format...' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='doc_cloud_format';
 
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






