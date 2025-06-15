SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_3.sql') AS properties;

SELECT 
    'breadcrumb' as component;
SELECT 
    'Home' as title,
    '/'    as link;
SELECT 
    'Gestion éditeur'         as title,
    '/a_panels/panel_editor_3.sql' as link;
SELECT 
    'Gestion des groupements'            as title,
    '/d_prm3/prm3_main_display_3.sql'      as link;

SELECT 
    'form' as component,
    'Créer un document' as title,
    'Créer' as validate,
    'Clear' as reset,
    '/d_prm3_doc/prm3_doc_main_create_0.sql?prm3_id='||$prm3_id as action;

SELECT
    'prm3_doc_title' as name,
    'text' as type,  
    'Titre' as label,
    'Choisissez un titre explicite pour faciliter les recherches' as description,
    TRUE as required,
    6 AS width;

SELECT 
    'file' as type, 
    'prm3_doc_url' as name,
    'document à insérer' as label,
    '*'  as accept,
    'size max : 5 MB' as description,
    TRUE       as required;

SELECT 
    'prm3_doc_summary' as name,
    'textarea' as type,
    'Résumé' as label,
    12 AS width;

SELECT 
    'prm3_doc_keywords' as name,
    'text' as type,
    'Mots clés' as label,
    'Séparez les mots par une virgule' as description,
    12 AS width;

SELECT 
    'prm3_doc_status'         as name,
    'Statut de publication'   as label,
    'select'                  as type,
    TRUE                      as required,
    4                        AS width,
    'Choisir un statut de pubication' as empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='status';

SELECT 
    'prm3_doc_category'        as name,
    'Catégorie'                 as label,
    'select'                 as type,
    4                       AS width,
    'Choisir une categorie...' as empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='doc_category';

SELECT 
    'prm3_doc_type'        as name,
    'Type de document'   as label,
    'select'                  as type,
    4                         AS width,
    'Choisir un type...' as empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='doc_type';

SELECT 
    'prm3_doc_date_publication' as name,
    'Date de publication' as label,
    'date'       as type, 
    3 AS width,
    '^[0-9]{4}-(((0[13578]|(10|12))-(0[1-9]|[1-2][0-9]|3[0-1]))|(02-(0[1-9]|[1-2][0-9]))|((0[469]|11)-(0[1-9]|[1-2][0-9]|30)))$' as pattern, 
    'format : DD-MM-YYYY' as description;
  
 SELECT 
    'prm3_doc_format'        as name,
    'Format'                 as label,
    'select'                 as type,
    2                       AS width,
    'Choisir un format...' as empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='doc_format';
 
