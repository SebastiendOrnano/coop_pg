SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SET workspace_id = SELECT workspace_id from workdocs_cloud WHERE workdoc_cloud_id=$workdoc_cloud_id::INTEGER;

SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT
    '/c_workspaces/workspace_hub_display_4.sql?workspace_id='||$workspace_id  AS link,
    'Retour hub du groupe de travail' AS title;
SELECT 
    'Gestion des documents'            AS title,
    '/c_workspaces/workdoc_cloud_display_4.sql?workspace_id='||$workspace_id  AS link;

SELECT 
    'form' AS component,
    'Actualiser un document' AS title,
    'Actualiser' AS validate,
    'Clear' AS reset,
    '/c_workspaces/workdoc_cloud_update_0.sql?workdoc_cloud_id='||$workdoc_cloud_id||'&workspace_id='||$workspace_id AS action;

SELECT
    'workdoc_cloud_title' AS name,
    'text' AS type,  
    'Titre' AS label,
    'Choisissez un titre explicite pour faciliter les recherches' AS description,
    (SELECT workdoc_cloud_title FROM workdocs_cloud WHERE workdoc_cloud_id=$workdoc_cloud_id::INTEGER ) AS value,
    'Rapport d''activité 2024' AS placeholder,
    TRUE AS required,
    12 AS width;

SELECT 
    'text' AS type, 
    'workdoc_cloud_url' AS name,
    (SELECT workdoc_cloud_url FROM workdocs_cloud WHERE workdoc_cloud_id=$workdoc_cloud_id::INTEGER) AS value,
    'URL du document partagé sur le cloud' AS label,
    TRUE       AS required;

SELECT 
    'workdoc_cloud_summary' AS name,
    'textarea' AS type,
    'Résumé' AS label,
    (SELECT workdoc_cloud_summary FROM workdocs_cloud WHERE workdoc_cloud_id=$workdoc_cloud_id::INTEGER ) AS value,
    12 AS width;

 SELECT 
    'workdoc_cloud_status'        AS name,
    'Statut'               AS label,
    'select'                AS type,
    (SELECT workdoc_cloud_status FROM workdocs_cloud WHERE workdoc_cloud_id=$workdoc_cloud_id::INTEGER ) AS value,
    2                       AS width,
    'Choisir un statut...' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='status';

SELECT 
    'workdoc_cloud_lang'        AS name,
    'Langue'               AS label,
    'select'                AS type,
    (SELECT workdoc_cloud_lang FROM workdocs_cloud WHERE workdoc_cloud_id=$workdoc_cloud_id::INTEGER ) AS value,
    2                       AS width,
    'Choisir une langue...' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='lang';
   
 SELECT 
    'workdoc_cloud_format'        AS name,
    'Format'                 AS label,
    'select'                 AS type,
    (SELECT workdoc_cloud_format FROM workdocs_cloud WHERE workdoc_cloud_id=$workdoc_cloud_id::INTEGER ) AS value,
    2                       AS width,
    'Choisir un format...' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='doc_format';
 
SELECT 
    'workdoc_cloud_category'        AS name,
    'Catégorie'                 AS label,
    'select'                 AS type,
    (SELECT workdoc_cloud_category FROM workdocs_cloud WHERE workdoc_cloud_id=$workdoc_cloud_id::INTEGER) AS value,
    3                       AS width,
    'Choisir une categorie...' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='doc_category';

SELECT 
    'workdoc_cloud_type'        AS name,
    'Type de document'   AS label,
    'select'                  AS type,
    (SELECT workdoc_cloud_type FROM workdocs_cloud WHERE workdoc_cloud_id=$workdoc_cloud_id::INTEGER ) AS value,
    3                         AS width,
    'Choisir un type...' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='doc_type';






