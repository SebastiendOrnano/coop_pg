SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;


SET project_name = SELECT project_name FROM project WHERE project_id=$project_id::INTEGER;

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
    ' hub du projet'            AS title,
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
    'project_nme_name' AS name,
    TRUE AS readonly,
    'Nom de la tranche de travaux de rattachement' AS label,
    5 AS width,
    (SELECT project_name  FROM project WHERE project_id = $project_id::INTEGER ) AS value;


SET waste_value = SELECT SUM(waste_value) FROM project_workpackage_waste WHERE  workpackage_id=$workpackage_id::INTEGER;

SELECT  'text' AS component;
SELECT 'Valorisation des déchets du projet :  '||$waste_value||' euros' AS contents_md

SELECT 
    'chart'             AS component,
    'pie'               AS type,
    'green'             AS color,
    'Répartition des déchets pat type' AS title,
    TRUE                AS labels;
SELECT 
    m.product_category_name AS label,
    SUM(e.waste_value)  AS value
FROM project_workpackage_waste AS e
LEFT JOIN (SELECT product_category_name, product_category_id FROM project_products_categories) AS m
ON m.product_category_id=e.waste_category_id
LEFT JOIN (SELECT workpackage_id, workpackage_name, workpackage_type, project_id FROM project_workpackage) AS w
ON e.workpackage_id=w.workpackage_id
LEFT JOIN (SELECT project_id, project_name FROM project) AS p
ON w.project_id=p.project_id
WHERE p.project_id=$project_id::INTEGER
GROUP BY m.product_category_name;


SELECT 
    'chart'             AS component,
    'pie'               AS type,
    'green'             AS color,
    'Répartition des coûts réel  du projet par type destination' AS title,
    TRUE                AS labels;

SELECT 
    e.waste_destination AS label,
    SUM(e.waste_value)  AS value
FROM project_workpackage_waste AS e
LEFT JOIN (SELECT workpackage_id, workpackage_name, workpackage_type, project_id FROM project_workpackage) AS w
ON e.workpackage_id=w.workpackage_id
LEFT JOIN (SELECT project_id, project_name FROM project) AS p
ON w.project_id=p.project_id
WHERE p.project_id=$project_id::INTEGER
GROUP BY e.waste_destination;