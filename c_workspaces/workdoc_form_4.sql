SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT
    '/c_workspaces/workspace_hub_display_4.sql?workspace_id='||$workspace_id  AS link,
    'Retour hub du groupe de travail' AS title;
SELECT 
    'Gestion des documents'            AS title,
    '/c_workspaces/workdoc_display_4.sql?workspace_id='||$workspace_id  AS link;

SELECT 
    'form' AS component,
    'Créer un document' AS title,
    'Créer' AS validate,
    'Clear' AS reset,
    '/c_workspaces/workdoc_create_0.sql?workspace_id='||$workspace_id AS action;

SELECT
    'workdoc_title' AS name,
    'text' AS type,  
    'Titre' AS label,
    'Choisissez un titre explicite pour faciliter les recherches' AS description,
    'Rapport d''activité 2024' AS placeholder,
    TRUE AS required,
    6 AS width;

SELECT
    'workdoc_author' AS name,
    'text' AS type,  
    'Author' AS label,
    6 AS width;

SELECT 
    'file' AS type, 
    'workdoc_url' AS name,
    'document à insérer' AS label,
    '*'  AS accept,
    'size max : 5 MB' AS description,
    TRUE       AS required;

SELECT 
    'workdoc_summary' AS name,
    'textarea' AS type,
    'Résumé' AS label,
    12 AS width;

SELECT 
    'workdoc_wersion' AS name,
    'text' AS type,
    'Version du doc' AS label,
    2 AS width;

 SELECT 
    'workdoc_lang'        AS name,
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
    'workdoc_format'        AS name,
    'Format'                 AS label,
    'select'                 AS type,
    2                       AS width,
    'Choisir un format...' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='doc_format';
 
SELECT 
    'workdoc_category'        AS name,
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
    'workdoc_type'        AS name,
    'Type de document'   AS label,
    'select'                  AS type,
    3                         AS width,
    'Choisir un type...' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='doc_type';






