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
    'Créer un espace de travail' AS title,
    'Créer' AS validate,
    'Reset' AS reset,
    '/c_workspaces/workspace_main_create_0.sql' AS action;

SELECT
    'workspace_title' AS name,
    'text' AS type,  
    'Nom de l''espace de travail' AS label,
    TRUE AS required,
    8 AS width,
    'Nom' AS placeholder;

SELECT
    'workspace_summary' AS name,
    'textarea'          AS type,  
    'Présentation'      AS label;

SELECT 
    'workspace_category' AS name,
    'categorie'          AS label,
    3                   AS width,
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
    'Choississez un statut dans la liste' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='status';


