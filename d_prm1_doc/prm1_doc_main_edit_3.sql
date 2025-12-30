SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_3.sql') AS properties;

SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion Superviseur'         AS title,
    '/a_panels/panel_supervisor_4.sql' AS link;
SELECT 
    'Gestion des docs d''une personne'            AS title,
    '/d_prm1_dept/prm1_dept_doc_display_4.sql?prm1_dept_id='||$prm1_dept_id     AS link;

SELECT 
    'form'                                           AS component,
    'Actualiser les métadonnées d''un document'      AS title,
    'Actualiser'                                     AS validate,
    'Clear'                                          AS reset,
    '/d_prm1_doc/prm1_doc_main_update_0.sql?prm1_doc_id='||$prm1_doc_id AS action

SELECT
    'prm1_doc_title'                     AS name,
    'text'                               AS type,  
    'Titre'                              AS label,
    (SELECT prm1_doc_title  FROM prm1_doc WHERE prm1_doc_id = $prm1_doc_id::INTEGER ) AS value,
    TRUE                                AS required,
    6                                   AS width;

SELECT
    'prm1_doc_author'         AS name,
    'text'                    AS type,  
    'Author'                  AS label,
    (SELECT prm1_doc_author  FROM prm1_doc WHERE prm1_doc_id = $prm1_doc_id::INTEGER ) AS value,
    6                        AS width;

SELECT 
    'file'                  AS type, 
    'prm1_doc_url'          AS name,
    'document à insérer'    AS label,
    '*'                     AS accept;

SELECT 
    'prm1_doc_summary'     AS name,
    'textarea'             AS type,
    'Résumé'               AS label,
    (SELECT prm1_doc_summary FROM prm1_doc WHERE prm1_doc_id = $prm1_doc_id::INTEGER ) AS value,
    12                     AS width;

SELECT 
    'prm1_doc_keywords'   AS name,
    'text'                AS type,
    'Mots clés'           AS label,
    (SELECT prm1_doc_keywords FROM prm1_doc WHERE prm1_doc_id = $prm1_doc_id::INTEGER ) AS value,
    'Séparez les mots par une virgule' AS description,
    12                    AS width;

SELECT 
    'prm1_doc_status'    AS name,
    'Statut de publication'   AS label,
    'select'                  AS type,
    4                         AS width,
    (SELECT prm1_doc_status FROM prm1_doc WHERE prm1_doc_id = $prm1_doc_id::INTEGER ) AS value,
    'Choisir un statut de pubication' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='status';

SELECT 
    'prm1_doc_category'      AS name,
    'Catégorie'              AS label,
    'select'                 AS type,
    4                       AS width,
    (SELECT prm1_doc_category FROM prm1_doc WHERE prm1_doc_id = $prm1_doc_id::INTEGER ) AS value,
    'Choisir une categorie...' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='doc_category';

SELECT 
    'prm1_doc_type'           AS name,
    'Type de document'        AS label,
    'select'                  AS type,
    (SELECT prm1_doc_type FROM prm1_doc WHERE prm1_doc_id = $prm1_doc_id::INTEGER ) AS value,
    4                         AS width,
    'Choisir un type...' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='doc_type';

 SELECT 
    'prm1_doc_date_publication' AS name,
    'Date de publication'       AS label,
    'date'                      AS type,
    (SELECT prm1_doc_date_publication  FROM prm1_doc WHERE prm1_doc_id = $prm1_doc_id::INTEGER ) AS value,
    3                            AS width,
    '^[0-9]{4}-(((0[13578]|(10|12))-(0[1-9]|[1-2][0-9]|3[0-1]))|(02-(0[1-9]|[1-2][0-9]))|((0[469]|11)-(0[1-9]|[1-2][0-9]|30)))$' AS pattern, 
    'format : DD-MM-YYYY'       AS description;

 SELECT 
    'prm1_doc_date_period'     AS name,
    'Période concernée'        AS label,
    'text'                      AS type,
    (SELECT prm1_doc_date_period  FROM prm1_doc WHERE prm1_doc_id = $prm1_doc_id::INTEGER ) AS value,
    2                         AS width,
    '^[0-9]{4}$'              AS pattern, 
    'format : YYYY'            AS description;

 SELECT 
    'prm1_doc_lang'         AS name,
    'Langue'                 AS label,
    'select'                 AS type,
    2                        AS width,
    (SELECT prm1_doc_lang FROM prm1_doc WHERE prm1_doc_id = $prm1_doc_id::INTEGER ) AS value,
    'Choisir une langue...' AS empty_option,
    '[
    {"label": "Français", "value": "FR"},
    {"label": "English", "value": "EN"}
    ]'                      AS options;


 SELECT 
    'prm1_doc_format'        AS name,
    'Format'                 AS label,
    'select'                 AS type,
    2                       AS width,
   (SELECT prm1_doc_format FROM prm1_doc WHERE prm1_doc_id = $prm1_doc_id::INTEGER ) AS value,
  'Choisir un format...' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='doc_format';
 


                                    



