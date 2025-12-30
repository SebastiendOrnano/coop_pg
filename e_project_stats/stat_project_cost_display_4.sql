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
    'Retour au hub du projet'            AS title,
    '/e_project/project_hub_display_4.sql?project_id='||$project_id     AS link;   

SELECT 
    'divider' AS component,
    'Nom du projet de rattachement : '||$project_name    AS contents,
    'blue' AS color;

SET project_cost_actual = 
SELECT SUM(e.expense_value) 
FROM project_workpackage_expenses AS e
LEFT JOIN (SELECT workpackage_id, project_id FROM project_workpackage) AS w
ON e.workpackage_id = w.workpackage_id
LEFT JOIN (SELECT  project_id FROM project) AS p
ON p.project_id = w.project_id
WHERE  p.project_id=$project_id::INTEGER;

SELECT  'text' AS component;
SELECT 'Coût réel du projet :  '||$project_cost_actual||' euros' AS contents_md


SELECT 
    'chart'             AS component,
    'pie'               AS type,
    'green'             AS color,
    'Répartition des coûts réel  du projet par lot de travaux' AS title,
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
GROUP BY w.workpackage_type;

SELECT 
    'chart'             AS component,
    'pie'               AS type,
    'green'             AS color,
    'Répartition des coûts réel  du projet par type dépenses' AS title,
    TRUE                AS labels;

SELECT 
    'type de dépenses'  AS series,
    e.expense_category AS label,
    SUM(e.expense_value)  AS value
FROM project_workpackage_expenses AS e
LEFT JOIN (SELECT workpackage_id, workpackage_name, workpackage_type, project_id FROM project_workpackage) AS w
ON e.workpackage_id=w.workpackage_id
LEFT JOIN (SELECT project_id, project_name FROM project) AS p
ON w.project_id=p.project_id
WHERE p.project_id = $project_id::INTEGER 
GROUP BY e.expense_category;


SET MinDate = SELECT MIN(expense_invoice_date) 
FROM project_workpackage_expenses AS e
LEFT JOIN (SELECT workpackage_id, workpackage_name, workpackage_type, project_id FROM project_workpackage) AS w
ON e.workpackage_id=w.workpackage_id
LEFT JOIN (SELECT project_id, project_name FROM project) AS p
ON w.project_id=p.project_id
WHERE p.project_id=$project_id::INTEGER;

SET MaxDate = SELECT MAX(expense_invoice_date) 
FROM project_workpackage_expenses AS e
LEFT JOIN (SELECT workpackage_id, workpackage_name, workpackage_type, project_id FROM project_workpackage) AS w
ON e.workpackage_id=w.workpackage_id
LEFT JOIN (SELECT project_id, project_name FROM project) AS p
ON w.project_id=p.project_id
WHERE p.project_id=$project_id::INTEGER;


SELECT 
    'chart'             AS component,
    'bar'               AS type,
    'green'             AS color,
    'Répartition des coûts par mois' AS title,
    TRUE                AS labels;

WITH RECURSIVE dates(d) AS 
(
    SELECT $MinDate::DATE

    UNION ALL

    SELECT DATE(d + interval '1 month') 
    FROM dates
    WHERE d < $MaxDate::DATE
)

SELECT
    TO_CHAR(e.expense_invoice_date, 'YYYY-MM')        AS label,
    SUM(e.expense_value)                              AS value
FROM project_workpackage_expenses AS e
JOIN dates ON TO_CHAR(e.expense_invoice_date, 'YYYY-MM') = TO_CHAR( dates.d, 'YYYY-MM')
LEFT JOIN (SELECT workpackage_id, workpackage_name, workpackage_type, project_id FROM project_workpackage) AS w
ON e.workpackage_id=w.workpackage_id
LEFT JOIN (SELECT project_id, project_name FROM project) AS p
ON w.project_id=p.project_id
WHERE p.project_id=$project_id::INTEGER
GROUP BY label
ORDER BY value DESC;
