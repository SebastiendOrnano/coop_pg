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
    'Gestion des categories'            AS title,
    '/a_choices/choice_category_display_5.sql'      AS link;


SELECT 
    'form' AS component,
    'Actualiser une categorie de choix' AS title,
    'Actualiser' AS validate,
    '/a_choices/choice_category_update_0.sql?choice_category_id='||$choice_category_id AS action;


SELECT
'choice_category_name' AS name,
'text' AS type,  
'Nom de la categorie' AS label,
(SELECT choice_category_name FROM choices_categories WHERE choice_category_id::INTEGER  = $choice_category_id::INTEGER ) AS value,
 4 AS width,
TRUE AS required;

SELECT
'choice_category_summary' AS name,
'text' AS type,  
'Description de la catégorie' AS label,
(SELECT choice_category_summary FROM choices_categories WHERE choice_category_id::INTEGER  = $choice_category_id::INTEGER ) AS value,
 4 AS width;

SELECT
'choice_category_status' AS name,
'select' AS type,  
'Statut' AS label,
(SELECT choice_category_status FROM choices_categories WHERE choice_category_id::INTEGER  = $choice_category_id::INTEGER ) AS value,
 4 AS width,
TRUE AS required,
    'Choisir un statut dans la liste...' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label', i.choice_label, 'value', i.choice_value)) AS options
    FROM choices_items AS i 
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories) AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE c.choice_category_name = 'status';


