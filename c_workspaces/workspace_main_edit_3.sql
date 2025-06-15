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
    'Gestion des espaces de travail'            AS title,
     '/c_workspaces/workspace_main_display_3.sql'  AS link;

SELECT 
    'form' AS component,
    'Actualiser les données d''un espace de travail' AS title,
    'Mettre à jour' AS validate,
    'Clear' AS reset,
    '/c_workspaces/workspace_main_update_0.sql?workspace_id='||$workspace_id  AS action;

SELECT
    'workspace_title' AS name,
    'text' AS type,  
    'Nom de l''espace de travail' AS label,
    (SELECT workspace_title FROM workspaces WHERE workspace_id=$workspace_id::INTEGER ) AS value,
    TRUE AS required,
    8 AS width,
    'Nom' AS placeholder;

SELECT
    'workspace_summary' AS name,
    'textarea'          AS type,
    (SELECT workspace_summary FROM workspaces WHERE workspace_id=$workspace_id::INTEGER ) AS value,  
    'Présentation'      AS label;

SELECT 
    'workspace_category' AS name,
    'categorie'          AS label,
    3                   AS width,
    (SELECT workspace_category FROM workspaces WHERE workspace_id=$workspace_id::INTEGER ) AS value,
    'select'                 AS type,    
    'Choississez une categorie dans la liste' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='workspace_category';

SELECT 
    'workspace_status'       AS name,
    'Statut'                 AS label,
    'select'                 AS type,
    3                       AS width,
    TRUE                     AS required,
    (SELECT workspace_status FROM workspaces WHERE workspace_id=$workspace_id::INTEGER ) AS value,
    'Choississez un statut dans la liste' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='status';
