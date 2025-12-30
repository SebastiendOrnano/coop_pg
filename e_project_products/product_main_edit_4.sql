SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion Superviseur'         AS title,
    '/a_panels/panel_supervisor_4.sql' AS link;
 SELECT 
    'Retour au projet'            AS title,
    '/e_project/project_main_display_4.sql'   AS link;   
SELECT 
    'Gestion des matériaux'            AS title,
    '/e_project_products/product_main_display_4.sql'    AS link;

SELECT 
    'form' AS component,
    'Actualiser une référence matériau' AS title,
    'Actualiser' AS validate,
    'Clear' AS reset,
    '/e_project_products/product_main_update_0.sql?product_id='||$product_id AS action;

SELECT
    'product_status' AS name,
    'select' AS type,  
    'Statut' AS label,
    (SELECT product_status FROM project_products WHERE product_id = $product_id::INTEGER ) AS value,
    2 AS width,
    TRUE AS required,
    'Choisir un statut dans la liste...'    AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='status';

SELECT
    'product_name' AS name,
    'text' AS type,  
    'Nom' AS label,
    (SELECT product_name FROM project_products WHERE product_id = $product_id::INTEGER ) AS value,
    10 AS width,
    TRUE AS required;

SELECT
    'product_ienes_url' AS name,
    'text' AS type,  
    'URL Fiche base IENES' AS label,
    (SELECT product_ienes_url FROM project_products WHERE product_id = $product_id::INTEGER ) AS value,
    12 AS width,
    TRUE AS required;

SELECT 
    'product_functional_unit'                AS name,
    'Unité fonctionnelle'                 AS label,
    'textarea'                           AS type,
    (SELECT product_functional_unit FROM project_products WHERE product_id = $product_id::INTEGER ) AS value,
    12                                  AS width;

SELECT 
    'product_unit'                AS name,
    'Unité'                 AS label,
    'text'                           AS type,
    (SELECT product_unit FROM project_products WHERE product_id = $product_id::INTEGER ) AS value,
    4                                  AS width;

SELECT 
    'product_climate_change_indicator'                AS name,
    'Indicateur réchauffement climatique total'                 AS label,
    'text'                           AS type,
    (SELECT product_climate_change_indicator::NUMERIC FROM project_products WHERE product_id = $product_id::INTEGER ) AS value,
    'kg CO2 eq.'                     AS suffix,
    4                                AS width;

SELECT
    'product_summary' AS name,
    'textarea' AS type,
    (SELECT product_summary FROM project_products WHERE product_id = $product_id::INTEGER ) AS value,
    12                                  AS width,
    'Commentaires' AS label;