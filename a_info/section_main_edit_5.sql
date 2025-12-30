SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_5.sql') AS properties;

SELECT 
    'breadcrumb' as component;
SELECT 
    'Home' as title,
    '/'    as link;
SELECT 
    'Gestion admin'         as title,
    '/a_panels/panel_admin_5.sql' as link;
 SELECT 
    'Liste des sections'            as title,
    '/a_info/section_main_display_5.sql'     as link;   

SELECT 
    'form'                        as component,
    'Mise à jour d''une section'  as title ,
    'Mettre à jour de la section' as validate,
    'Annuler'                     as reset,
    'green'                       as validate_color,
    '/a_info/section_main_update_0.sql?section_id='||$section_id  as action;

SELECT 
    'section_id' as name,
    'hidden' as type,
     4                     AS width,
    (SELECT section_id  FROM  info_sections WHERE section_id = $section_id::INTEGER )   as value,
    'Id' as label;

SELECT 
    'section_category' as name,
    'readonly' as type,
     4                     AS width,
    (SELECT section_category  FROM  info_sections WHERE section_id = $section_id::INTEGER )   as value,
    'Catégorie' as label;

SELECT 
    'section_number'      as name,
    'text'                as type,
    2                    AS width,
    'N° d''ordre de la section' as label,
    (SELECT section_number  FROM  info_sections WHERE section_id = $section_id::INTEGER )   as value;
   
SELECT
    'section_lang'                               as name,
    'select'                                     as type,  
    'Langue'                                     as label,
    TRUE                                         as required,
    2                                            AS width,
    (SELECT section_lang  FROM  info_sections WHERE section_id = $section_id::INTEGER )   AS value,
    'choisir une langue dans la liste...'    AS  empty_option,
    json_agg(JSON_BUILD_OBJECT('label', i.choice_label, 'value', i.choice_value)) AS options
    FROM choices_items AS i 
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories) AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE c.choice_category_name = 'lang';


SELECT 
    'section_status'        as name,
    'statut de publication actuel'      as label,
    'select'                            as type,
    4                    AS width,
    (SELECT section_status  FROM  info_sections WHERE section_id = $section_id::INTEGER )   AS value,
    'Choisir un statut dans la liste...' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label', i.choice_label, 'value', i.choice_value)) AS options
    FROM choices_items AS i 
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories) AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE c.choice_category_name = 'status';

SELECT 
    'section_title' as name,
    'text' as type,
    (SELECT section_title  FROM  info_sections WHERE section_id = $section_id::INTEGER )   as value,
    'titre de la section' as label;

SELECT
    'section_content' as name,
    'textarea' as type,  
    'Contenu de la section' as label,
    (SELECT section_content  FROM info_sections WHERE section_id = $section_id::INTEGER ) as value;


