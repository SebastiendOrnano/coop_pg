SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_3.sql') AS properties;

SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion éditeur'         AS title,
    '/a_panels/panel_editor_3.sql' AS link;
 SELECT 
    'liste des projets'            AS title,
    '/e_project/project_main_display_3.sql'     AS link;
 SELECT 
    'hub du projet'            AS title,
    '/e_project/project_hub_display_3.sql?project_id='||$project_id     AS link; SELECT 
    'breadcrumb' AS component;
SELECT 
    'Gestion des docs'            AS title,
    '/e_project_docs/project_doc_main_display_4.sql?project_id='||$project_id     AS link;

    
SELECT 
    'form'                                           AS component,
    'Actualiser les métadonnées d''un document'      AS title,
    'Actualiser'                                     AS validate,
    'Clear'                                          AS reset,
    '/e_project_docs/project_doc_main_update_0.sql?project_doc_id='||$project_doc_id||'&project_id='||$project_id AS action

SELECT 
    'project_doc_id'    AS name,
    'hidden'         AS type,
    $project_doc_id     AS value,
    'id'              AS label;

SELECT
    'project_doc_title'                     AS name,
    'text'                               AS type,  
    'Titre'                              AS label,
    (SELECT project_doc_title  FROM project_docs WHERE project_doc_id = $project_doc_id::INTEGER ) AS value,
    TRUE                                AS required,
    6                                   AS width;

SELECT
    'project_doc_author'         AS name,
    'text'                    AS type,  
    'Author'                  AS label,
    (SELECT project_doc_author  FROM project_docs WHERE project_doc_id = $project_doc_id::INTEGER ) AS value,
    6                        AS width;

SELECT 
    'file'                  AS type, 
    'project_doc_url'          AS name,
    'document à insérer'    AS label,
    '*'                     AS accept;

SELECT 
    'project_doc_summary'     AS name,
    'textarea'             AS type,
    'Résumé'               AS label,
    (SELECT project_doc_summary FROM project_docs WHERE project_doc_id = $project_doc_id::INTEGER ) AS value,
    12                     AS width;

SELECT 
    'project_doc_keywords'   AS name,
    'text'                AS type,
    'Mots clés'           AS label,
    (SELECT project_doc_keywords FROM project_docs WHERE project_doc_id = $project_doc_id::INTEGER ) AS value,
    'Séparez les mots par une virgule' AS description,
    12                    AS width;

 SELECT 
    'project_doc_date_publication' AS name,
    'Date de publication'       AS label,
    'date'                      AS type,
    (SELECT project_doc_date_publication  FROM project_docs WHERE project_doc_id = $project_doc_id::INTEGER ) AS value,
    3                            AS width,
   (SELECT regex_value FROM regex WHERE regex_name='date')         AS pattern,
   (SELECT regex_description FROM regex WHERE regex_name='date')          AS description;

 SELECT 
    'project_doc_date_period'     AS name,
    'Période concernée'        AS label,
    'text'                      AS type,
    (SELECT project_doc_date_period  FROM project_docs WHERE project_doc_id = $project_doc_id::INTEGER ) AS value,
    2                         AS width,
   (SELECT regex_value FROM regex WHERE regex_name='year')         AS pattern,
   (SELECT regex_description FROM regex WHERE regex_name='year')          AS description;

 SELECT 
    'project_doc_lang'         AS name,
    'Langue'                 AS label,
    'select'                 AS type,
    2                        AS width,
    (SELECT project_doc_lang FROM project_docs WHERE project_doc_id = $project_doc_id::INTEGER ) AS value,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='lang';


 SELECT 
    'project_doc_format'        AS name,
    'Format'                 AS label,
    'select'                 AS type,
    2                       AS width,
   (SELECT project_doc_format FROM project_docs WHERE project_doc_id = $project_doc_id::INTEGER ) AS value,
  'Choisir un format...' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='doc_format';
 
SELECT 
    'project_doc_category'      AS name,
    'Catégorie'              AS label,
    'select'                 AS type,
    3                       AS width,
    (SELECT project_doc_category FROM project_docs WHERE project_doc_id = $project_doc_id::INTEGER ) AS value,
    'Choisir une categorie...' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='doc_category';

SELECT 
    'project_doc_type'           AS name,
    'Type de document'        AS label,
    'select'                  AS type,
    (SELECT project_doc_type FROM project_docs WHERE project_doc_id = $project_doc_id::INTEGER ) AS value,
    3                         AS width,
    'Choisir un type...' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='doc_type';

                                    
SELECT 
    'project_doc_status'    AS name,
    'Statut de publication'   AS label,
    'select'                  AS type,
    3                         AS width,
    (SELECT project_doc_status FROM project_docs WHERE project_doc_id = $project_doc_id::INTEGER ) AS value,
    'Choisir un statut de publication..' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='status';


