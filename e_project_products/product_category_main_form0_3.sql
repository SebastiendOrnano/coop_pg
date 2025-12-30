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
    'Créer une categorie de matériaux : étape 1' AS title,
    'Créer' AS validate,
    '/e_project_products/product_category_main_create0_0.sql' AS action;

SELECT 
    'product_choice_category'              AS name,
    'radio'                  AS type,
    'independant'                   AS value,
    'Non lié à une autre catégorie' AS description,
    'categorie indépendante'                   AS label;
SELECT 
    'product_choice_category' AS name,
    'radio'     AS type,
    'linked'       AS value,
    'Lié à une autre catégorie' AS description,
    'sous catégorie'       AS label;


