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
    'Gestion des documents'            AS title,
     '/d_prm2_sub/prm2_sub_doc_display_4.sql?prm2_sub_id='||$prm2_sub_id  AS link;

SELECT 
    'form' AS component,
    'Créer un document' AS title,
    'Créer' AS validate,
    'Clear' AS reset,
    '/d_prm2_sub_doc/prm2_sub_doc_main_create_0.sql?prm2_sub_id='||$prm2_sub_id AS action;

SELECT
    'prm2_sub_doc_title' AS name,
    'text' AS type,  
    'Titre' AS label,
    'Choisissez un titre explicite pour faciliter les recherches' AS description,
    'Rapport d''activité 2024' AS placeholder,
    TRUE AS required,
    6 AS width;

SELECT
    'prm2_sub_doc_author' AS name,
    'text' AS type,  
    'Author' AS label,
    6 AS width;

SELECT 
    'file' AS type, 
    'prm2_sub_doc_url' AS name,
    'document à insérer' AS label,
    '*'  AS accept,
    'size max : 5 MB' AS description,
    TRUE       AS required;

SELECT 
    'prm2_sub_doc_summary' AS name,
    'textarea' AS type,
    'Résumé' AS label,
    12 AS width;

SELECT 
    'prm2_sub_doc_keywords' AS name,
    'text' AS type,
    'Mots clés' AS label,
    'Séparez les mots par une virgule' AS description,
    12 AS width;

SELECT 
    'prm2_sub_doc_date_publication' AS name,
    'Date de publication' AS label,
    'date'       AS type, 
    3 AS width,
   (SELECT regex_value FROM regex WHERE regex_name='date')         AS pattern,
   (SELECT regex_description FROM regex WHERE regex_name='date')          AS description;

 SELECT 
    'prm2_sub_doc_date_period' AS name,
    'Période concernée' AS label,
    'text'       AS type,
    2 AS width,
   (SELECT regex_value FROM regex WHERE regex_name='year')         AS pattern,
   (SELECT regex_description FROM regex WHERE regex_name='year')          AS description;

 SELECT 
    'prm2_sub_doc_lang'        AS name,
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
    'prm2_sub_doc_format'        AS name,
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
    'prm2_sub_doc_category'        AS name,
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
    'prm2_sub_doc_type'        AS name,
    'Type de document'   AS label,
    'select'                  AS type,
    3                         AS width,
    'Choisir un type...' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='doc_type';
