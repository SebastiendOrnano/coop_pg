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
    'Projets'         AS title,
    '/e_project/project_main_display_3.sql'     AS link;
SELECT 
    'Listes des matériaux'         AS title,
    '/e_project_products/product_main_display_3.sql'     AS link;
    
set product_category_parent_id = SELECT product_category_id FROM project_products_categories WHERE product_category_id = :product_category_id;


SELECT 
    'form' AS component,
    '' AS validate;
SELECT
    'product_category_id' AS name,
    'text' AS type,  
    'id ' AS label,
    2 AS width,
     (SELECT product_category_id FROM project_products_categories WHERE product_category_id=:product_category_id::INTEGER ) AS value;
SELECT
    'product_category_name' AS name,
    'text' AS type,  
    'Nom de la catégorie parente' AS label,
    10 AS width,
     (SELECT product_category_name FROM project_products_categories WHERE product_category_id=:product_category_id::INTEGER ) AS value;


SELECT 
    'form' AS component,
    'Créer une categorie - étape 2 : définir la catégorie' AS title,
    'Créer' AS validate,
    '/e_project_products/product_category_main_create2_0.sql' AS action;

SELECT
    'product_category_parent_id' AS name,
    'hidden' AS type,
    $product_category_parent_id AS value;

SELECT
    'product_category_name' AS name,
    'text' AS type,  
    'Nom de la categorie' AS label,
    4 AS width,
    TRUE AS required;

SELECT
    'product_category_summary' AS name,
    'text' AS type,  
    'Description de la categorie' AS label,
    8 AS width;


