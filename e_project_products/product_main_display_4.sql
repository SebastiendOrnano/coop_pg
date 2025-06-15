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
    'View'           AS markdown,
    'Nom'           AS markdown,
    TRUE             AS sort, 
    TRUE             AS search;

SELECT
    product_category_id               AS Id,
    product_name            AS Nom,
    product_summary         AS Description,
   '[Edit](/e_project_products/product_main_edit_4.sql?product_id=' || product_id || ')&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Delete](/e_project_products/product_main_delete_0.sql?product_id='||product_id|| ')'    AS View
FROM project_products
WHERE product_status ='active'
ORDER BY product_name  ASC;