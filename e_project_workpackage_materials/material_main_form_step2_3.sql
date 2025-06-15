SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_3.sql') AS properties;

set workpackage_name = SELECT workpackage_name FROM project_workpackage WHERE workpackage_id = $workpackage_id::INTEGER ;
set project_id=SELECT project_id FROM project_workpackage WHERE workpackage_id=$workpackage_id::INTEGER ;

SET  product_climate_change_indicator= SELECT product_climate_change_indicator  FROM project_products WHERE product_id=:product_id::INTEGER;


SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion éditeur'         AS title,
    '/a_panels/panel_editor_3.sql' AS link;
SELECT 
    'Projets'            AS title,
    '/e_project/project_main_display_3.sql'   AS link;   
 SELECT 
    'Hub projet'            AS title,
    '/e_project/project_hub_display_3.sql?project_id='||$project_id     AS link;   
SELECT 
    'Hub lot de travaux'            AS title,
    '/e_project_workpackage/workpackage_hub_display_3.sql?workpackage_id='||$workpackage_id    AS link;
SELECT 
    'Matériaux'            AS title,
    '/e_project_workpackage_materials/material_main_display_3.sql?workpackage_id='||$workpackage_id AS link;

SELECT 
    'form' AS component,
    'Données ienes' AS title,
    '' AS validate;

SELECT
    'product_name' AS name,
    'text' AS type,  
    'Nom' AS label,
    6 AS width,
    (SELECT product_name FROM project_products WHERE product_id=:product_id::INTEGER) AS value;

SELECT
    'product_ienes_url' AS name,
    'text' AS type,  
    'Lien ienes' AS label,
    6 AS width,
    (SELECT product_ienes_url FROM project_products WHERE product_id=:product_id::INTEGER) AS value;


SELECT
    'product_functional_unit' AS name,
    'textarea' AS type,  
    'Unité fonctionnelle' AS label,
    9 AS width,
    (SELECT product_functional_unit FROM project_products WHERE product_id=:product_id::INTEGER) AS value;

SELECT
    'product_unit' AS name,
    'text' AS type,  
    'Unité' AS label,
    3 AS width,
    (SELECT product_unit FROM project_products WHERE product_id=:product_id::INTEGER) AS value;
SELECT
    'product_climate_change_indicator' AS name,
    'text' AS type,  
    'Indicateur chgt climatique' AS label,
    6 AS width,
    (SELECT product_climate_change_indicator FROM project_products WHERE product_id=:product_id::INTEGER) AS value;


SELECT 
    'form' AS component,
    'Calcul du bilan carbone' AS title,
    'Créer' AS validate,
    'Clear' AS reset,
    '/e_project_workpackage_materials/material_main_create_0.sql?workpackage_id='||$workpackage_id  AS action;

SELECT
    'material_summary' AS name,
    'textarea' AS type,
    'Détail du calcul' AS label;
SELECT
    'material_unit' AS name,
    'select'             AS type,
    2                  AS width,
    'Unité'         AS label,
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
    'Quantité'         AS label;

SELECT
    'material_volume1' AS name,
    'text'             AS type,
    'l'                AS suffix,
    2                  AS width,
    'Volume 1(liquides)'         AS label;

SELECT
    'material_volume2' AS name,
    'text'            AS type,
    'm3'              AS suffix,
    2                 AS width,
    'Volume 2 m3'        AS label;

SELECT
    'material_area' AS name,
    'text'            AS type,
    'm2'              AS suffix,
    2                AS width,
    'Superficie'        AS label;

SELECT
    'material_thickness' AS name,
    'text'            AS type,
    'mm'             AS suffix,
    2                AS width,
    'Épaisseur'        AS label;

SELECT
    'material_length' AS name,
    'text'            AS type,
    'ml'              AS suffix,
    2                 AS width,
    'longueur'        AS label;

SELECT
    'material_weigth' AS name,
    'text'            AS type,
    'kg'              AS suffix,
    2                 AS width,
    'poids'        AS label;

SELECT
    'material_equiv_fonctional_units' AS name,
    'text'            AS type,
    6                 AS width,
    true              AS required,
    'Nb equiv d''unités fonctionnelles'        AS label;

SELECT
    'product_climate_change_indicator' AS name,
    'hidden' AS type,
    (SELECT product_climate_change_indicator::NUMERIC  FROM project_products WHERE product_id=:product_id::INTEGER) AS value;

SELECT
    'product_ienes_url' AS name,
    'hidden' AS type,
    (SELECT product_ienes_url FROM project_products WHERE product_id=:product_id::INTEGER) AS value;
SELECT
    'product_id' AS name,
    'hidden' AS type,
    (SELECT product_id  FROM project_products WHERE product_id=:product_id::INTEGER) AS value;
