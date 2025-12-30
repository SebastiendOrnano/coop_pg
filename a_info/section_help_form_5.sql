SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_5.sql') AS properties;

SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion Admin'         AS title,
    '/a_panels/panel_admin_5.sql' AS link;

SELECT 
    'Gestion des sections d''aide'            AS title,
    '/a_info/section_help_display_5.sql' AS link;



SELECT 
    'form' AS component,
    'Section de l''aide pour les dev' AS title,
    'Créer' AS validate,
    'Clear' AS reset,
    '/a_info/section_help_create_0.sql' AS action;

SELECT 
    'section_status'        AS name,
    'statut de publication actuel'      AS label,
    'select'                            AS type,
    4                                   AS width,
    'Choisir un statut dans la liste...' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label', i.choice_label, 'value', i.choice_value)) AS options
    FROM choices_items AS i 
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories) AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE c.choice_category_name = 'status';

SELECT
    'section_number' AS name,
    'number' AS type,  
    'Numéro de la section' AS label,
    2 AS width,
    '1, 2, 3...' AS description;

SELECT
    'section_lang'                               AS name,
    'select'                                     AS type,  
    'Langue'                                     AS label,
    TRUE                                         AS required,
    2                                            AS width,
    'choisir une langue dans la liste...'    AS  empty_option,
    json_agg(JSON_BUILD_OBJECT('label', i.choice_label, 'value', i.choice_value)) AS options
    FROM choices_items AS i 
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories) AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE c.choice_category_name = 'lang';

SELECT
    'section_title' AS name,
    'text' AS type,  
    'Titre de la section' AS label,
    'Titre de la section' AS placeholder;

SELECT
    'section_content' AS name,
    'textarea' AS type,  
    'Contenu de la section' AS label,
    'Contenu de la section au format markdown' AS description;



