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
    'Projets'            AS title,
    '/e_project/project_main_display_4.sql'     AS link;
 SELECT 
    'Hub du projet'            AS title,
    '/e_project/project_hub_display_4.sql?project_id='||$project_id     AS link; 
SELECT 
    'Hub lot de travaux'    AS title,
    '/e_project_workpackage/workpackage_hub_display_4.sql?workpackage_id='||$workpackage_id AS link;
SELECT 
    'Déchets'            AS title,
    '/e_project_workpackage_waste/waste_main_display_4.sql?workpackage_id='||$workpackage_id    AS link;


SELECT 
    'form' AS component,
    'Energistrer un déchet' AS title,
    'Créer' AS validate,
    'Clear' AS reset,
    '/e_project_workpackage_waste/waste_main_form_step2_4.sql?workpackage_id='||$workpackage_id AS action;


SELECT 
    'waste_category_id'                AS name,
    'Catégorie'                 AS label,
    'select'                           AS type,
    3                                  AS width,
    TRUE                              AS required,
    'Choisir un type dans la liste'   AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',product_category_name, 'value', product_category_id))  AS options
    FROM project_products_categories 
    WHERE product_category_parent_id IS NULL ;

