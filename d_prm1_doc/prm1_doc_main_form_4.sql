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
    '/d_prm1_doc/prm1_doc_main_display_4.sql?prm1_id='||$prm1_id  AS link;

SELECT 
    'form' AS component,
    'Créer un document' AS title,
    'Créer' AS validate,
    'Clear' AS reset,
    '/d_prm1_doc/prm1_doc_main_create_0.sql?prm1_id='||$prm1_id AS action;

SELECT
    'prm1_doc_title' AS name,
    'text' AS type,  
    'Titre' AS label,
    'Choisissez un titre explicite pour faciliter les recherches' AS description,
    TRUE AS required,
    6 AS width;

SELECT
    'prm1_doc_author' AS name,
    'text' AS type,  
    'Author' AS label,
    6 AS width;

SELECT 
    'file' AS type, 
    'prm1_doc_url' AS name,
    'document à insérer' AS label,
    '*'  AS accept,
    'size max : 5 MB' AS description,
    TRUE       AS required;

SELECT 
    'prm1_doc_summary' AS name,
    'textarea' AS type,
    'Résumé' AS label,
    12 AS width;

SELECT 
    'prm1_doc_keywords' AS name,
    'text' AS type,
    'Mots clés' AS label,
    'Séparez les mots par une virgule' AS description,
    12 AS width;

SELECT 
    'prm1_doc_status'         AS name,
    'Statut de publication'   AS label,
    'select'                  AS type,
    TRUE                      AS required,
    4                        AS width,
    'Choisir un statut de pubication' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='status';

SELECT 
    'prm1_doc_category'        AS name,
    'Catégorie'                 AS label,
    'select'                 AS type,
    4                       AS width,
    'Choisir une categorie...' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='doc_category';

SELECT 
    'prm1_doc_type'        AS name,
    'Type de document'   AS label,
    'select'                  AS type,
    4                         AS width,
    'Choisir un type...' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='doc_type';


SELECT 
    'prm1_doc_date_publication' AS name,
    'Date de publication' AS label,
    'date'       AS type, 
    3 AS width,
   (SELECT regex_value FROM regex WHERE regex_name='date')         AS pattern,
   (SELECT regex_description FROM regex WHERE regex_name='date')          AS description;

 SELECT 
    'prm1_doc_date_period' AS name,
    'Période concernée' AS label,
    'text'       AS type,
    2 AS width,
   (SELECT regex_value FROM regex WHERE regex_name='year')         AS pattern,
   (SELECT regex_description FROM regex WHERE regex_name='year')          AS description;

 SELECT 
    'prm1_doc_lang'        AS name,
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
    'prm1_doc_format'        AS name,
    'Format'                 AS label,
    'select'                 AS type,
    2                       AS width,
    'Choisir un format...' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='doc_format';
 











