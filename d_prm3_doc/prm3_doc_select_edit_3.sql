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
    'Gestion des documents'            as title,
    '/d_prm3_doc/prm3_doc_main_display_3.sql?prm3_id='||$prm3_id  as link;
SELECT 
    'Sélection de docs d''un groupement'            as title,
    '/d_prm3_doc/prm3_doc_select_display_3.sql?prm3_id='||$prm3_id     as link;

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
    '/d_prm3_doc/prm3_doc_select_update_0.sql?prm3_id='||$prm3_id as action

SELECT 
    'prm3_doc_selected' as name,
    'hidden' as type,
     true as value,
    'prm3_doc_selected' as label;

SELECT 
    'prm3_doc_keywords' as name,
    'text' as type,
    'Mots clés' as label,
    'Séparez les mots par une virgule' as description,
    6 AS width;

SELECT 
    'prm3_doc_status'         as name,
    'Statut de publication'   as label,
    'select'                  as type,
    4                         AS width,
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
   (SELECT regex_value FROM regex WHERE regex_name='date')         AS pattern,
   (SELECT regex_description FROM regex WHERE regex_name='date')          AS description;

 SELECT 
    'prm3_doc_lang'        as name,
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
 

