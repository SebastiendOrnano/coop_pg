SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SELECT 
    'alert'                     as component,
    TRUE as important,
    'Les modifications dans le formulaire seront appliquées à tous les documents sélectionnées !' as description,
    'alert-triangle'            as icon,
      TRUE                       as dismissible,
    'yellow'                    as color;

SELECT 
    'form' as component,
    'Actualiser les métadonnées d''une série de documents' as title,
    'Actualiser' as validate,
    'Clear' as reset,
    '/b_orga_dept_doc/orga_dept_doc_select_update_0.sql?orga_dept_id='||$orga_dept_id  as action

SELECT 
    'orga_doc_selected' as name,
    'hidden' as type,
     true as value,
    'orga_doc_selected' as label;

SELECT 
    'orga_doc_author' as name,
    'text' as type,
    'Auteur(s)' as label,
    6 AS width;

SELECT 
    'orga_doc_keywords' as name,
    'text' as type,
    'Mots clés' as label,
    'Séparez les mots par une virgule' as description,
    6 AS width;

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
    'orga_doc_status'        as name,
    'Statut de publication'   as label,
    'select'                  as type,
    3                         AS width,
    TRUE                      as required,
    'Choisir un statut de pubication' as empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='status';
