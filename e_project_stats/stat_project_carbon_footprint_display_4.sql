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
    'Retour au hub du projet'            AS title,
    '/e_project/project_hub_display_4.sql?project_id='||$project_id     AS link;   

SELECT 
    'form'   AS component,
    '' AS validate;

SELECT
    'project_id' AS name,
    TRUE AS readonly,
    'Id ' AS label,
    1 AS width,
   $project_id AS value;

SELECT
    'project_name' AS name,
    TRUE AS readonly,
    'Nom du projet de rattachement' AS label,
    11 AS width,
    (SELECT project_name  FROM project WHERE project_id = $project_id::INTEGER ) AS value;

SELECT 
    'chart'             AS component,
    'bar'               AS type,
    'green'             AS color,
    'Bilan carbone par tranche de travaux (kg CO2 eq.) ' AS title,
    TRUE                AS labels;
SELECT 
    w.workpackage_type AS label,
    SUM(m.material_carbon_footprint)  AS value
FROM project_workpackage_materials AS m
LEFT JOIN (SELECT workpackage_id, workpackage_name, workpackage_type, project_id FROM project_workpackage) AS w
ON m.workpackage_id=w.workpackage_id
LEFT JOIN (SELECT project_id, project_name FROM project) AS p
ON w.project_id=p.project_id
WHERE p.project_id=$project_id::INTEGER
GROUP BY w.workpackage_type;




