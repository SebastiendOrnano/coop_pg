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
    'form'                                           as component,
    'Actualiser les métadonnées d''un document'      as title,
    'Actualiser'                                     as validate,
    'Clear'                                          as reset,
    '/d_prm3_doc/prm3_doc_main_update_0.sql?prm3_doc_id='||$prm3_doc_id as action

SELECT
    'prm3_doc_title'                     as name,
    'text'                               as type,  
    'Titre'                              as label,
    (SELECT prm3_doc_title  FROM prm3_docs WHERE prm3_doc_id = $prm3_doc_id::INTEGER ) as value,
    TRUE                                as required,
    6                                   AS width;

SELECT 
    'file'                  as type, 
    'prm3_doc_url'          as name,
    'document à insérer'    as label,
    '*'                     as accept;

SELECT 
    'prm3_doc_summary'     as name,
    'textarea'             as type,
    'Résumé'               as label,
    (SELECT prm3_doc_summary FROM prm3_docs WHERE prm3_doc_id = $prm3_doc_id::INTEGER ) as value,
    12                     AS width;

SELECT 
    'prm3_doc_keywords'   as name,
    'text'                as type,
    'Mots clés'           as label,
    (SELECT prm3_doc_keywords FROM prm3_docs WHERE prm3_doc_id = $prm3_doc_id::INTEGER ) as value,
    'Séparez les mots par une virgule' as description,
    12                    AS width;

SELECT 
    'prm3_doc_status'    as name,
    'Statut de publication'   as label,
    'select'                  as type,
    4                         AS width,
    (SELECT prm3_doc_status FROM prm3_docs WHERE prm3_doc_id = $prm3_doc_id::INTEGER ) as value,
    'Choisir un statut de pubication' as empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='status';

SELECT 
    'prm3_doc_category'      as name,
    'Catégorie'              as label,
    'select'                 as type,
    4                       AS width,
    (SELECT prm3_doc_category FROM prm3_docs WHERE prm3_doc_id = $prm3_doc_id::INTEGER ) as value,
    'Choisir une categorie...' as empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='doc_category';

SELECT 
    'prm3_doc_type'           as name,
    'Type de document'        as label,
    'select'                  as type,
    (SELECT prm3_doc_type FROM prm3_docs WHERE prm3_doc_id = $prm3_doc_id::INTEGER ) as value,
    4                         AS width,
    'Choisir un type...' as empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='doc_type';

 SELECT 
    'prm3_doc_date_publication' as name,
    'Date de publication'       as label,
    'date'                      as type,
    (SELECT prm3_doc_date_publication  FROM prm3_docs WHERE prm3_doc_id = $prm3_doc_id::INTEGER ) as value,
    3                            AS width,
   (SELECT regex_value FROM regex WHERE regex_name='date')         AS pattern,
   (SELECT regex_description FROM regex WHERE regex_name='date')          AS description;

SELECT 
    'prm3_doc_format'        as name,
    'Format'                 as label,
    'select'                 as type,
    2                       AS width,
   (SELECT prm3_doc_format FROM prm3_docs WHERE prm3_doc_id = $prm3_doc_id::INTEGER ) as value,
  'Choisir un format...' as empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='doc_format';
 