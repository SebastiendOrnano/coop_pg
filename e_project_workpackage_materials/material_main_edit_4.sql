SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

set workpackage_id= SELECT workpackage_id FROM project_workpackage_materials WHERE material_id=$material_id::INTEGER;
set workpackage_name = SELECT workpackage_name FROM project_workpackage WHERE workpackage_id = $workpackage_id::INTEGER ;
set project_id=SELECT project_id FROM project_workpackage WHERE workpackage_id=$workpackage_id::INTEGER ;
set product_id=SELECT product_id FROM project_workpackage_materials WHERE material_id=$material_id::INTEGER;


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
    'Matériaux'            AS title,
    '/e_project_workpackage_materials/material_main_display_4.sql?workpackage_id='||$workpackage_id AS link;


SELECT 
    'form' AS component,
    'Données ienes' AS title,
    '' AS validate;

SELECT
    'product_name' AS name,
    'text' AS type,  
    'Nom' AS label,
    6 AS width,
    (SELECT product_name FROM project_products WHERE product_id=$product_id::INTEGER ) AS value;

SELECT
    'product_ienes_url' AS name,
    'text' AS type,  
    'Lien ienes' AS label,
    6 AS width,
    (SELECT product_ienes_url FROM project_products WHERE product_id=$product_id::INTEGER ) AS value;


SELECT
    'product_functional_unit' AS name,
    'textarea' AS type,  
    'Unité fonctionnelle' AS label,
    9 AS width,
    (SELECT product_functional_unit FROM project_products WHERE product_id=$product_id::INTEGER ) AS value;

SELECT
    'product_unit' AS name,
    'text' AS type,  
    'Unité' AS label,
    3 AS width,
    (SELECT product_unit FROM project_products WHERE product_id=$product_id::INTEGER ) AS value;
SELECT
    'product_climate_change_indicator' AS name,
    'text' AS type,  
    'Indicateur chgt climatique' AS label,
    6 AS width,
    (SELECT product_climate_change_indicator FROM project_products WHERE product_id=$product_id::INTEGER ) AS value;


SELECT 
    'form' AS component,
    'Calcul du bilan carbone' AS title,
    'Actualiser le calcul bilan carbone' AS validate,
    'Clear' AS reset,
    '/e_project_workpackage_materials/material_main_update_0.sql?material_id='||$material_id  AS action;

SELECT
    'material_status'  AS name,
    'select'           AS type,
    2                  AS width,
    (SELECT material_status FROM project_workpackage_materials WHERE material_id=$material_id::INTEGER ) AS value,
    'Choisir un statut dans la liste...'    AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='status';

SELECT
    'material_summary'       AS name,
    'textarea'               AS type,
    (SELECT material_summary FROM project_workpackage_materials WHERE material_id=$material_id::INTEGER ) AS value,
    'Détail du calcul'       AS label;

SELECT
    'material_unit' AS name,
    'select'             AS type,
    2                  AS width,
    'Unité'         AS label,
    (SELECT material_unit FROM project_workpackage_materials WHERE material_id=$material_id::INTEGER ) AS value,
    'Choisir dans la liste'   AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='material_unit';

SELECT
    'material_quantity' AS name,
    'text'             AS type,
    2                  AS width,
    (SELECT material_quantity FROM project_workpackage_materials WHERE material_id=$material_id::INTEGER ) AS value,
    'Quantité'         AS label;

SELECT
    'material_volume1' AS name,
    'text'             AS type,
    'l'                AS suffix,
    2                  AS width,
    (SELECT material_volume1 FROM project_workpackage_materials WHERE material_id=$material_id::INTEGER ) AS value,
    'Volume 1 (liquides)'         AS label;

SELECT
    'material_volume2' AS name,
    'text'            AS type,
    'm3'              AS suffix,
    2                 AS width,
    (SELECT material_volume2 FROM project_workpackage_materials WHERE material_id=$material_id::INTEGER ) AS value,
    'Volume 2 (solides)'        AS label;

SELECT
    'material_area' AS name,
    'text'            AS type,
    'm2'              AS suffix,
    2                AS width,
    (SELECT material_area FROM project_workpackage_materials WHERE material_id=$material_id::INTEGER ) AS value,
    'Superficie'        AS label;

SELECT
    'material_thickness' AS name,
    'text'            AS type,
    'm'              AS suffix,
    2                AS width,
    (SELECT material_thickness FROM project_workpackage_materials WHERE material_id=$material_id::INTEGER ) AS value,
    'Épaisseur'        AS label;

SELECT
    'material_length' AS name,
    'text'            AS type,
    'ml'              AS suffix,
    2                 AS width,
     (SELECT material_length FROM project_workpackage_materials WHERE material_id=$material_id::INTEGER ) AS value,
    'longueur'        AS label;

SELECT
    'material_weigth' AS name,
    'text'            AS type,
    'kg'              AS suffix,
    2                 AS width,
     (SELECT material_weigth FROM project_workpackage_materials WHERE material_id=$material_id::INTEGER ) AS value,
    'poids'        AS label;

SELECT
    'material_equiv_fonctional_units' AS name,
    'text'            AS type,
    6                 AS width,
    true              AS required,
     (SELECT material_equiv_fonctional_units FROM project_workpackage_materials WHERE material_id=$material_id::INTEGER ) AS value,
    'Nb equiv d''unités fonctionnelles'        AS label;

SELECT
    'product_climate_change_indicator' AS name,
    'hidden' AS type,
    (SELECT product_climate_change_indicator  FROM project_products WHERE product_id=$product_id::INTEGER ) AS value;

SELECT
    'product_ienes_url' AS name,
    'hidden' AS type,
    (SELECT product_ienes_url FROM project_products WHERE product_id=$product_id::INTEGER ) AS value;
SELECT
    'product_id' AS name,
    'hidden' AS type,
    (SELECT product_id  FROM project_products WHERE product_id=$product_id::INTEGER ) AS value;