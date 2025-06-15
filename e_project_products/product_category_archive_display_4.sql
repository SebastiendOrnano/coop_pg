SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion Admin'         AS title,
    '/a_panels/panel_supervisor_4.sql' AS link;
SELECT 
    'Listes des project'         AS title,
    '/e_project/project_main_display_4.sql'     AS link;
SELECT 
    'Listes des matériaux actifs'         AS title,
    '/e_project_products/product_category_main_display_4.sql'     AS link;



-- Display list of organizations
SELECT 'table' AS component, 
    'Liste des categories'   AS title, 
    'View'           AS markdown,
    'Nom'           AS markdown,
    TRUE             AS sort, 
    TRUE             AS search;

WITH RECURSIVE tree_category_view AS (
    SELECT 
        product_category_id,
        product_category_parent_id,
        product_category_name,
        product_category_status,
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
        p.product_category_status,
        level + 1 AS level,
        CAST(order_sequence  || '_' || CAST(p.product_category_id AS integer) AS integer) AS order_sequence,
        CAST(order_sequence2 || '_' || CAST(p.product_category_id AS TEXT) AS TEXT) AS order_sequence2
    FROM project_products_categories AS p
    JOIN tree_category_view AS t
    ON p.product_category_parent_id = t.product_category_id
)

SELECT
    order_sequence2                                  AS order_sequence2,
    CASE
    WHEN product_category_parent_id is NOT NULL
    THEN substr('------------',1,3 * level)||product_category_name            
    ELSE UPPER(product_category_name)  
    END                                              AS Nom,
    '[Edit](/e_project_products/product_category_main_edit_4.sql?product_category_id=' || product_category_id || ')&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Delete](/e_project_products/product_category_main_delete_0.sql?product_category_id=' || product_category_id|| ')'    AS View
FROM tree_category_view WHERE product_category_status != 'active'
ORDER BY coalesce(product_category_parent_id, product_category_id), (product_category_parent_id IS NULL) desc, product_category_id desc;
