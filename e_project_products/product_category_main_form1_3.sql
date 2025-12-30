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
    'Créer une categorie - étape 2' AS title,
    'Créer' AS validate,
    '/e_project_products/product_category_main_create1_0.sql' AS action;

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


