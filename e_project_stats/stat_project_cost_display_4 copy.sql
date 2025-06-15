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
    'divider' AS component,
    'Nom du projet de rattachement'    AS contents,
    'blue' AS color;


SELECT 
    'chart'             AS component,
    'pie'               AS type,
    'green'             AS color,
    'Répartition des coûts réel  du projet' AS title,
    TRUE                AS labels;
SELECT 
    w.workpackage_type AS label,
    SUM(e.expense_value)  AS value
FROM project_workpackage_expenses AS e
LEFT JOIN (SELECT workpackage_id, workpackage_name, workpackage_type, project_id FROM project_workpackage) AS w
ON e.workpackage_id=w.workpackage_id
LEFT JOIN (SELECT project_id, project_name FROM project) AS p
ON w.project_id=p.project_id
WHERE p.project_id=$project_id::INTEGER
GROUP BY e. workpackage_id;






