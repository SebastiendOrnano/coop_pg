SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion admin'         AS title,
    '/a_panels/panel_supervisor_4.sql' AS link;
SELECT 
    'Listes des project'         AS title,
    '/e_project/project_main_display_4.sql'     AS link;
SELECT 
    'Listes des matériaux'         AS title,
    '/e_project_products/product_main_display_4.sql'     AS link;
SELECT 
    'Catégorie de matériaux'         AS title,
    '/e_project_products/product_category_main_display_4.sql'     AS link;

SELECT 
    'form' AS component,
    'Actualiser une categorie de choix' AS title,
    'Actualiser' AS validate,
    '/e_project_products/product_category_main_update_0.sql?product_category_id='||$product_category_id AS action;

SELECT
    'product_category_name' AS name,
    'text' AS type,  
    'Nom de la categorie' AS label,
    (SELECT product_category_name FROM project_products_categories WHERE product_category_id = $product_category_id::INTEGER ) AS value,
    4 AS width,
    TRUE AS required;

SELECT
    'product_category_summary' AS name,
    'text' AS type,  
    'Description de la catégorie' AS label,
    (SELECT product_category_summary FROM project_products_categories WHERE product_category_id = $product_category_id::INTEGER ) AS value,
    4 AS width;

SELECT
    'product_category_status' AS name,
    'select' AS type,  
    'Statut de la categorie' AS label,
    4 AS width,
    TRUE AS required,
    (SELECT product_category_status FROM project_products_categories WHERE product_category_id = $product_category_id::INTEGER ) AS value,
    'choisir unstatut dans la liste...'    AS  empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='status';


