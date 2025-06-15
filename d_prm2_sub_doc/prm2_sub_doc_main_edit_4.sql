SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SET prm2_sub_id = (SELECT prm2_sub_id FROM prm2_sub_docs WHERE prm2_sub_doc_id = $prm2_sub_doc_id::INTEGER);
SET prm2_id = (SELECT prm2_id FROM prm2_sub WHERE prm2_sub_id = $prm2_sub_id::INTEGER);

SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion Superviseur'         AS title,
    '/a_panels/panel_supervisor_4.sql' AS link;
SELECT 
    'Gestion des organisation'            AS title,
    '/d_prm2/prm2_doc_main_display_4.sql'   AS link;
SELECT 
    'Gestion d''une filiale'            AS title,
    '/d_prm2_sub/prm2_sub_main_display_4.sql?prm2_id='||$prm2_id   AS link;
SELECT 
    'Gestion des docs d''une filiale'            AS title,
    '/d_prm2_sub_doc/prm2_sub_doc_main_display_4.sql?prm2_sub_id='||$prm2_sub_id   AS link;

SELECT 
    'form'                                           AS component,
    'Actualiser les métadonnées d''un document'      AS title,
    'Actualiser'                                     AS validate,
    'Clear'                                          AS reset,
    '/d_prm2_sub_doc/prm2_sub_doc_main_update_0.sql?prm2_sub_doc_id='||$prm2_sub_doc_id||'&prm2_sub_id='||$prm2_sub_id AS action

SELECT 
    'prm2_sub_id'    AS name,
    'hidden'         AS type,
    $prm2_sub_id     AS value,
    'id'              AS label;

SELECT
    'prm2_sub_doc_title'                     AS name,
    'text'                               AS type,  
    'Titre'                              AS label,
    (SELECT prm2_sub_doc_title  FROM prm2_sub_docs WHERE prm2_sub_doc_id = $prm2_sub_doc_id::INTEGER ) AS value,
    TRUE                                AS required,
    6                                   AS width;

SELECT
    'prm2_sub_doc_author'         AS name,
    'text'                    AS type,  
    'Author'                  AS label,
    (SELECT prm2_sub_doc_author  FROM prm2_sub_docs WHERE prm2_sub_doc_id = $prm2_sub_doc_id::INTEGER ) AS value,
    6                        AS width;

SELECT 
    'file'                  AS type, 
    'prm2_sub_doc_url'          AS name,
    'document à insérer'    AS label,
    '*'                     AS accept;

SELECT 
    'prm2_sub_doc_summary'     AS name,
    'textarea'             AS type,
    'Résumé'               AS label,
    (SELECT prm2_sub_doc_summary FROM prm2_sub_docs WHERE prm2_sub_doc_id = $prm2_sub_doc_id::INTEGER ) AS value,
    12                     AS width;

SELECT 
    'prm2_sub_doc_keywords'   AS name,
    'text'                AS type,
    'Mots clés'           AS label,
    (SELECT prm2_sub_doc_keywords FROM prm2_sub_docs WHERE prm2_sub_doc_id = $prm2_sub_doc_id::INTEGER ) AS value,
    'Séparez les mots par une virgule' AS description,
    12                    AS width;

 SELECT 
    'prm2_sub_doc_date_publication' AS name,
    'Date de publication'       AS label,
    'date'                      AS type,
    (SELECT prm2_sub_doc_date_publication  FROM prm2_sub_docs WHERE prm2_sub_doc_id = $prm2_sub_doc_id::INTEGER ) AS value,
    3                            AS width,
   (SELECT regex_value FROM regex WHERE regex_name='date')         AS pattern,
   (SELECT regex_description FROM regex WHERE regex_name='date')          AS description;

 SELECT 
    'prm2_sub_doc_date_period'     AS name,
    'Période concernée'        AS label,
    'text'                      AS type,
    (SELECT prm2_sub_doc_date_period  FROM prm2_sub_docs WHERE prm2_sub_doc_id = $prm2_sub_doc_id::INTEGER ) AS value,
    2                         AS width,
   (SELECT regex_value FROM regex WHERE regex_name='year')         AS pattern,
   (SELECT regex_description FROM regex WHERE regex_name='year')          AS description;

 SELECT 
    'prm2_sub_doc_lang'         AS name,
    'Langue'                 AS label,
    'select'                 AS type,
    2                        AS width,
    (SELECT prm2_sub_doc_lang FROM prm2_sub_docs WHERE prm2_sub_doc_id = $prm2_sub_doc_id::INTEGER ) AS value,
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
   (SELECT prm2_sub_doc_format FROM prm2_sub_docs WHERE prm2_sub_doc_id = $prm2_sub_doc_id::INTEGER ) AS value,
  'Choisir un format...' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='doc_format';
 
SELECT 
    'prm2_sub_doc_category'      AS name,
    'Catégorie'              AS label,
    'select'                 AS type,
    3                       AS width,
    (SELECT prm2_sub_doc_category FROM prm2_sub_docs WHERE prm2_sub_doc_id = $prm2_sub_doc_id::INTEGER ) AS value,
    'Choisir une categorie...' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='doc_category';

SELECT 
    'prm2_sub_doc_type'           AS name,
    'Type de document'        AS label,
    'select'                  AS type,
    (SELECT prm2_sub_doc_type FROM prm2_sub_docs WHERE prm2_sub_doc_id = $prm2_sub_doc_id::INTEGER ) AS value,
    3                         AS width,
    'Choisir un type...' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='doc_type';

                                    
SELECT 
    'prm2_sub_doc_status'    AS name,
    'Statut de publication'   AS label,
    'select'                  AS type,
    3                         AS width,
    (SELECT prm2_sub_doc_status FROM prm2_sub_docs WHERE prm2_sub_doc_id = $prm2_sub_doc_id::INTEGER ) AS value,
    'Choisir un statut de publication..' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='status';


