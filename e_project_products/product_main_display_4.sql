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
    'Retour à la liste des projets'            AS title,
    '/e_project/project_main_display_4.sql'     AS link;

SELECT 
    'datagrid'              AS component,
    'panel_project_display' AS id;
SELECT 
    '/e_project_products/product_main_form_step1_4.sql'      AS link,
    'Création d''un materiau'                  AS description,
    'trash'                                      AS icon,
    'yellow'                                         AS color;
SELECT 
    '/e_project_products/product_archive_display_4.sql'           AS link,
    'Visualiser les materiaux achivées'           AS description,
    'archive'                                     AS icon,
    'green'                                              AS color;
SELECT 
    '/e_project_products/product_category_main_display_4.sql'           AS link,
    'Catégories de matériaux'                      AS description,
    'list-details'                                     AS icon,
    'red'                                       AS color;

SELECT 
    'divider' AS component,
    'Liste des materiaux employés sur les projets'    AS contents,
    'blue' AS color;



SELECT 'table' AS component, 
    '/e_project_products/product_main_edit_4.sql?product_id={id}' as edit_url,
    '/e_project_products/product_main_delete_0.sql?product_id={id}' as delete_url,
    'Nom'           AS markdown,
    TRUE             AS sort, 
    TRUE             AS search;

WITH RECURSIVE tree_category_view AS (
    SELECT 
        product_category_id,
        product_category_parent_id,
        product_category_name,
        0 AS level,
        CAST(product_category_id AS integer) AS order_sequence,
        CAST(product_category_id AS TEXT) AS order_sequence2
    FROM project_products_categories
    WHERE product_category_parent_id IS NULL
    
UNION 

    SELECT 
        p.product_category_id,
        p.product_category_parent_id,
        p.product_category_name,
        level + 1 AS level,
        CAST(order_sequence  || '_' || CAST(p.product_category_id AS integer) AS integer) AS order_sequence,
        CAST(order_sequence2 || '_' || CAST(p.product_category_id AS TEXT) AS TEXT) AS order_sequence2
    FROM project_products_categories AS p
    JOIN tree_category_view AS t
    ON p.product_category_parent_id = t.product_category_id
)

SELECT
        product_id               AS _sqlpage_id,
    (SELECT product_category_name FROM project_products_categories WHERE product_category_id=t.product_category_parent_id) AS cat1,
    t.product_category_name                                       AS Cat2,
    '['||p.product_name||']('||p.product_ienes_url||')'            AS Nom,
    p.product_climate_change_indicator                            AS IndicCO2
FROM tree_category_view AS t
LEFT JOIN (SELECT product_id, product_name, product_category_id, product_climate_change_indicator, product_ienes_url, product_status FROM project_products) AS p
on t.product_category_id=p.product_category_id
WHERE p.product_status='active'
ORDER BY t.order_sequence;