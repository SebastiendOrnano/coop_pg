SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion éditeur'         AS title,
    '/a_panels/panel_editor_3.sql' AS link;
SELECT 
    'Listes des project'         AS title,
    '/e_project/project_main_display_3.sql'     AS link;
SELECT 
    'Listes des matériaux'         AS title,
    '/e_project_products/product_main_display_3.sql'     AS link;

SELECT 
    'form' AS component,
    'Enregistrer un materiau' AS title,
    'Créer' AS validate,
    'Clear' AS reset,
    '/e_project_products/product_main_create_0.sql' AS action;

SELECT 
    'product_category_id'            AS name,
    'Catégorie'                  AS label,
    'select'                       AS type,
    4                             AS width,
    TRUE AS required,
'Choisir une categorie dans la liste...'    AS  empty_option,
json_agg(JSON_BUILD_OBJECT(
    'label', product_category_name,
    'value', product_category_id
)) AS options
FROM project_products_categories WHERE product_category_parent_id=:product_category_id::INTEGER;

SELECT
    'product_name' AS name,
    'text' AS type,  
    'Nom' AS label,
    9 AS width,
    TRUE AS required;

SELECT
    'product_ienes_url' AS name,
    'text' AS type,  
    'URL Fiche base IENES' AS label,
    12 AS width,
    TRUE AS required;

SELECT 
    'product_functional_unit'                AS name,
    'Unité fonctionnelle'                 AS label,
    'textarea'                           AS type,
    12                                  AS width;

SELECT 
    'product_unit'                AS name,
    'Unité'                 AS label,
    'text'                           AS type,
    4                                  AS width;

SELECT 
    'product_climate_change_indicator'                AS name,
    'Indicateur réchauffement climatique total'                 AS label,
    'text'                           AS type,
    'kg CO2 eq.'                     AS suffix,
    4                                AS width;

SELECT
    'product_summary' AS name,
    'textarea' AS type,
    12                                  AS width,
    'Commentaires' AS label;


