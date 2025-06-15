SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_3.sql') AS properties;

set workpackage_name = SELECT workpackage_name FROM project_workpackage WHERE workpackage_id = $workpackage_id::INTEGER ;
set project_id=SELECT project_id FROM project_workpackage WHERE workpackage_id=$workpackage_id::INTEGER ;

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
    'datagrid'              AS component,
    'Calcul du bilan carbone matériaux du lot de travaux' AS title,
    'panel_project_display' AS id;
SELECT 
    '/e_project_workpackage_materials/material_main_form_step1_3.sql?workpackage_id='||$workpackage_id      AS link,
    'Création d''un materiau'                  AS description,
    'alarm-smoke'                                      AS icon,
    'yellow'                                         AS color;

SELECT 
    'divider' AS component,
    'Bilan carbone - Liste des materiaux sur le de travaux : '||$workpackage_name    AS contents,
    'blue' AS color;

SELECT 
    'table'               AS component, 
    'Liste des materiaux sur le de travaux : '||$workpackage_name AS title, 
    TRUE                  AS sort, 
    'View'                AS markdown,
    'Inv'                AS markdown, 
    FALSE                 AS search;

SELECT
    m.material_id                            AS Id,
    p.product_name                           AS Nom,
    p.product_climate_change_indicator       AS Indicator,
    m.material_equiv_fonctional_units        AS EquivUnitFonction,
    m.material_carbon_footprint              AS BilanCarbone,
'[Edit](/e_project_workpackage_materials/material_main_edit_3.sql?material_id=' 
||m.material_id||')'    AS View
FROM project_workpackage_materials AS m
LEFT JOIN (SELECT product_id, product_name,product_climate_change_indicator FROM project_products ) AS p
ON p.product_id = m.product_id
WHERE m.material_status='active' and m.workpackage_id=$workpackage_id::INTEGER
ORDER BY p.product_name ASC;

SELECT 
    ''                        AS Id,
    'TOTAL'                       AS Nom,
     ''                       AS Indicator,
      ''                AS EquivUnitFonction,
    SUM(m.material_carbon_footprint)     AS value,
    true                      AS _sqlpage_footer
FROM project_workpackage_materials AS m
LEFT JOIN (SELECT product_id, product_name,product_climate_change_indicator FROM project_products ) AS p
ON p.product_id = m.product_id
WHERE m.material_status='active' and m.workpackage_id=$workpackage_id::INTEGER;


