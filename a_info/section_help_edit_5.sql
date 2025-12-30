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
    'form'                        AS component,
    'Mise à jour d''une section'  AS title ,
    'Mettre à jour de la section' AS validate,
    'Annuler'                     AS reset,
    'green'                       AS validate_color,
    '/a_info/section_help_update_0.sql?section_id='||$section_id  AS action;


SELECT 
    'section_category' AS name,
    'readonly' AS type,
     4                     AS width,
    (SELECT section_category  FROM  info_sections WHERE section_id = $section_id::INTEGER )   AS value,
    'Catégorie' AS label;

SELECT 
    'section_number'      AS name,
    'number'                AS type,
    2                    AS width,
    'N° d''ordre de la section' AS label,
    (SELECT section_number  FROM  info_sections WHERE section_id = $section_id::INTEGER )   AS value;
   
SELECT
    'section_lang'                               AS name,
    'select'                                     AS type,  
    'Langue'                                     AS label,
    TRUE                                         AS required,
    2                                            AS width,
    (SELECT section_lang  FROM  info_sections WHERE section_id = $section_id::INTEGER )   AS value,
    'choisir une langue dans la liste...'    AS  empty_option,
    json_agg(JSON_BUILD_OBJECT('label', i.choice_label, 'value', i.choice_value)) AS options
    FROM choices_items AS i 
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories) AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE c.choice_category_name = 'lang';


SELECT 
    'section_status'        AS name,
    'statut de publication actuel'      AS label,
    'select'                            AS type,
    4                    AS width,
    (SELECT section_status  FROM  info_sections WHERE section_id = $section_id::INTEGER )   AS value,
    'Choisir un statut dans la liste...' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label', i.choice_label, 'value', i.choice_value)) AS options
    FROM choices_items AS i 
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories) AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE c.choice_category_name = 'status';

SELECT 
    'section_title' AS name,
    'text' AS type,
    (SELECT section_title  FROM  info_sections WHERE section_id = $section_id::INTEGER )   AS value,
    'titre de la section' AS label;

SELECT
    'section_content' AS name,
    'textarea' AS type,  
    'Contenu de la section' AS label,
    (SELECT section_content  FROM info_sections WHERE section_id = $section_id::INTEGER ) AS value;


