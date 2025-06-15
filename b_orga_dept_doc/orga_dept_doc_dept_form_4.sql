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
    'Gestion des documents'            as title,
     '/b_orga_dept/orga_dept_doc_display_4.sql?orga_dept_id='||$orga_dept_id  as link;

SELECT 
    'form' as component,
    'Créer un document' as title,
    'Créer' as validate,
    'Clear' as reset,
    '/b_orga_dept_doc/orga_dept_doc_dept_create_0.sql' as action;

SELECT
    'orga_doc_title' as name,
    'text' as type,  
    'Titre' as label,
    'Choisissez un titre explicite pour faciliter les recherches' as description,
    'Rapport d''activité 2024' as placeholder,
    TRUE as required,
    6 AS width;

SELECT
    'orga_doc_author' as name,
    'text' as type,  
    'Author' as label,
    6 AS width;

SELECT 
    'file' as type, 
    'orga_doc_url' as name,
    'document à insérer' as label,
    '*'  as accept,
    'size max : 5 MB' as description,
    TRUE       as required;

SELECT 
    'orga_doc_summary' as name,
    'textarea' as type,
    'Résumé' as label,
    12 AS width;

SELECT 
    'orga_doc_keywords' as name,
    'text' as type,
    'Mots clés' as label,
    'Séparez les mots par une virgule' as description,
    12 AS width;

SELECT 
    'orga_dept_id' as name,
    'nom du département ou de la filiale' as label,
    'hidden' as type,
    $orga_dept_id as value;

 SELECT 
    'orga_doc_date_publication' as name,
    'Date de publication' as label,
    'date'       as type, 
    3 AS width,
  (SELECT regex_value FROM regex WHERE regex_name='date')         as pattern,
   (SELECT regex_description FROM regex WHERE regex_name='date')          as description;

 SELECT 
    'orga_doc_date_period' as name,
    'Période concernée' as label,
    'text'       as type,
    2 AS width,
  (SELECT regex_value FROM regex WHERE regex_name='year')         as pattern,
   (SELECT regex_description FROM regex WHERE regex_name='year')          as description;

 SELECT 
    'orga_doc_lang'        as name,
    'Langue'               as label,
    'select'                as type,
    2                       AS width,
    'Choisir une langue...' as empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='lang';
   
 SELECT 
    'orga_doc_format'        as name,
    'Format'                 as label,
    'select'                 as type,
    2                       AS width,
    'Choisir un format...' as empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='doc_format';
 
SELECT 
    'orga_doc_page_number' as name,
    'number' as type,
    'Nombre de pages' as label,
    '^[0-9]{4})$' as pattern, 
    'format : 1234' as description,
    3 AS width;

SELECT 
    'orga_doc_category'        as name,
    'Catégorie'                 as label,
    'select'                 as type,
    3                       AS width,
    'Choisir une categorie...' as empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='doc_category';

SELECT 
    'orga_doc_type'        as name,
    'Type de document'   as label,
    'select'                  as type,
    3                         AS width,
    'Choisir un type...' as empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='doc_type';



SELECT 
    'orga_doc_edition'        as name,
    'Statut d''édition'      as label,
    'select'                 as type,
    3                        AS width,
    'Choisir un statut d''édition' as empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='edition_status';


SELECT 
    'orga_doc_status'    as name,
    'Statut de publication'   as label,
    'select'                  as type,
    TRUE                      as required,
    3                         AS width,
    'Choisir un statut de pubication' as empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='status';





