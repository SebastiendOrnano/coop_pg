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
    'datagrid'                 AS component,
    'panel_product_choice_display'     AS id,
    'Gestion des catégories'   AS title;
SELECT 
    '/e_project_products/product_category_main_form0_3.sql'     AS link,
    'Création d''une nouvelle catégorie'     AS description,
    'tournament'                                      AS icon,
    'yellow'                                          AS color;


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
        CAST(product_category_id AS INTEGER) AS order_sequence1,
        CAST(product_category_id AS TEXT) AS order_sequence2
    FROM project_products_categories
    WHERE product_category_parent_id IS NULL
    
UNION 

    SELECT 
        p.product_category_id,
        p.product_category_parent_id,
        p.product_category_name,
        p.    product_category_status,
        level + 1 AS level,
        CAST(order_sequence1  || '_' || CAST(p.product_category_id AS INTEGER) AS INTEGER) AS order_sequence1,
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
    '[Edit](/e_project_products/product_category_main_edit_3.sql?product_category_id=' || product_category_id ||')'    AS View
FROM tree_category_view WHERE product_category_status = 'active'
ORDER BY coalesce(product_category_parent_id, product_category_id), (product_category_parent_id IS NULL) desc, product_category_id desc;
