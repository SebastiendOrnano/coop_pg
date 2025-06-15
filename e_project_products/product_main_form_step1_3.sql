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
    'Enregistrer un materiau - étape 1 : choisir la famille de matériau' AS title,
    'Créer' AS validate,
    'Clear' AS reset,
    '/e_project_products/product_main_form_step2_3.sql' AS action;

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
FROM project_products_categories WHERE product_category_parent_id IS NULL;

