SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

set workpackage_name = SELECT workpackage_name FROM project_workpackage WHERE workpackage_id = $workpackage_id::INTEGER ;
set project_id=SELECT project_id FROM project_workpackage WHERE workpackage_id=$workpackage_id::INTEGER ;

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
    'Hub projet'            AS title,
    '/e_project/project_hub_display_4.sql?project_id='||$project_id       AS link;
SELECT 
    'Hub lot de travaux'            AS title,
    '/e_project_workpackage/workpackage_hub_display_4.sql?workpackage_id='||$workpackage_id     AS link;
SELECT 
    'Gestion des matériaux'            AS title,
    '/e_project_workpackage_material/material_main_display_4.sql?workpackage_id='||$workpackage_id     AS link;

SELECT 
    'form' AS component,
    'Calcul BC - etape 1 choix du matériaux dans la base' AS title,
    'Créer' AS validate,
    'Clear' AS reset,
    '/e_project_workpackage_materials/material_main_form_step2_4.sql?workpackage_id='||$workpackage_id  AS action;


SELECT 
    'product_id'                       AS name,
    'Matériau'                       AS label,
    'select'                           AS type,
    3                                  AS width,
    TRUE                              AS required,
    'Choisir une catégorie dans la liste'   AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',product_name, 'value', product_id))  AS options
    FROM project_products;

