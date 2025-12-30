SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

set project_id=SELECT project_id FROM project_workpackage WHERE workpackage_id=$workpackage_id::INTEGER ;

SELECT 
    'breadcrumb' as component;
SELECT 
    'Home' as title,
    '/'    as link;
SELECT 
    'Gestion Superviseur'         as title,
    '/a_panels/panel_supervisor_4.sql' as link;
 SELECT 
    'Retour à la liste des projets'            as title,
    '/e_project/project_main_display_4.sql'     as link;
 SELECT 
    ' hub du projet'            as title,
    '/e_project/project_hub_display_4.sql?project_id='||$project_id     as link; 
SELECT 
    'Hub lot de travaux'            as title,
    '/e_project_workpackage/workpackage_hub_display_4.sql?workpackage_id='||$workpackage_id     as link;
 SELECT 
    'Gestion matériaux'            as title,
    '/e_project_workpackage_materials/material_main_display_4.sql?workpackage_id='||$workpackage_id as link;

SELECT 
    'form'   as component,
    '' as validate;
SELECT
    'project_id' as name,
    TRUE as readonly,
    'Id ' as label,
    1 as width,
   $project_id as value;

SELECT
    'project_name' as name,
    TRUE as readonly,
    'Nom de la tranche de travaux de rattachement' as label,
    5 as width,
    (SELECT project_name  FROM project WHERE project_id = $project_id::INTEGER ) as value;
SELECT
    'workpackage_id' as name,
    TRUE as readonly,
    'Id ' as label,
    1 as width,
   $workpackage_id as value;

SELECT
    'workpackage_name' as name,
    TRUE as readonly,
    'Nom de la tranche de travaux de rattachement' as label,
    5 as width,
    (SELECT workpackage_name  FROM project_workpackage WHERE workpackage_id = $workpackage_id::INTEGER ) as value;

SET workpackage_carbon_footprint = SELECT SUM(material_carbon_footprint) FROM project_workpackage_materials WHERE  workpackage_id=$workpackage_id::INTEGER;

SELECT  'text' as component;
SELECT 'Total empreinte carbone de la tranche de travaux :  '||$workpackage_carbon_footprint||' kg CO2 eq.' as contents_md


SELECT 
    'chart'             as component,
    'bar'               as type,
    'green'             as color,
    'Bilan carbone par matériaux dans la tranche de travaux (kg CO2 eq.) ' as title,
    TRUE                as labels;
SELECT 
    p.product_name               as label,
    SUM(m.material_carbon_footprint)  as value
FROM project_workpackage_materials as m
LEFT JOIN (SELECT product_id, product_name FROM project_products) as p
ON p.product_id=m.product_id
WHERE m.workpackage_id=$workpackage_id::INTEGER
GROUP BY p.product_name;






