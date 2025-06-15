SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_5.sql') AS properties;

SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion admin'         AS title,
    '/a_panels/panel_admin_5.sql' AS link;
 SELECT 
    'Liste des sections'            AS title,
    '/a_info/section_main_display_5.sql'     AS link;   

SELECT 
    'form' AS component,
    'Info sur le site - Infos légales - CGU - Help - Overview' AS title,
    'Créer' AS validate,
    'Clear' AS reset,
    '/a_info/section_main_create_0.sql' AS action;

SELECT 
    'section_category'           AS name,
    'Choix de la catégorie'      AS label,
    'select'                     AS type,
    TRUE                                         AS required,
    4                            AS width,
    'choisir une catégorie dans la liste...'    AS  empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='legal_info';

SELECT 
    'section_status'        AS name,
    'statut de publication actuel'      AS label,
    'select'                            AS type,
    4                                   AS width,
    TRUE                                         AS required,
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
    TRUE                                         AS required,
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
    TRUE                                         AS required,
    'Titre de la section' AS placeholder;

SELECT
    'section_content' AS name,
    'textarea' AS type,  
    'Contenu de la section' AS label,
    'Contenu de la section au format markdown' AS description;

