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


SELECT 
    'form' AS component,
    'Créer une categorie de choix' AS title,
    'Créer' AS validate,
    '/e_project_products/product_category_main_form3_3.sql' AS action;

SELECT 
   'product_category_id' AS name,
    'Création d''une catégorie - étape 2 : choisir la catégorie parent' AS label,
    'select' AS type,
    8 AS width,
    TRUE AS searchable,
    'Choisissez dans la liste' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label', product_category_name, 'value', product_category_id)) AS options
    FROM (
    SELECT product_category_name, product_category_id
    FROM project_products_categories WHERE product_category_parent_id='' or  product_category_parent_id IS NULL
    ORDER BY product_category_id ASC
    );