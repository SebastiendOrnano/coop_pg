SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;



set project_id=SELECT project_id FROM project_workpackage WHERE workpackage_id=$workpackage_id::INTEGER ;
SET project_name = SELECT project_name FROM project WHERE project_id=$project_id::INTEGER;

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
    'Nom du projet' as label,
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
    'Nom de la tranche de travaux' as label,
    5 as width,
    (SELECT workpackage_name  FROM project_workpackage WHERE workpackage_id = $workpackage_id::INTEGER ) as value;

SET workpackage_cost_actual = SELECT SUM(expense_value) FROM project_workpackage_expenses WHERE  workpackage_id=$workpackage_id::INTEGER;

SELECT  'text' as component;
SELECT 'Coût de la tranche de travaux :  '||$workpackage_cost_actual||' euros' as contents_md

SELECT 
    'chart'             as component,
    'pie'               as type,
    'green'             as color,
    'Répartition des coûts réel  du projet par type dépenses' as title,
    TRUE                as labels;

SELECT 
    'type de dépenses'  as series,
    e.expense_category as label,
    SUM(e.expense_value)  as value
FROM project_workpackage_expenses as e
LEFT JOIN (SELECT workpackage_id, workpackage_name, workpackage_type, project_id FROM project_workpackage) as w
ON e.workpackage_id=w.workpackage_id
LEFT JOIN (SELECT project_id, project_name FROM project) as p
ON w.project_id=p.project_id
WHERE w.workpackage_id=$workpackage_id::INTEGER
GROUP BY e.expense_category;


SET MinDate = SELECT MIN(expense_invoice_date) 
 FROM project_workpackage_expenses as e
LEFT JOIN (SELECT workpackage_id, workpackage_name, workpackage_type, project_id FROM project_workpackage) as w
ON e.workpackage_id=w.workpackage_id
LEFT JOIN (SELECT project_id, project_name FROM project) as p
ON w.project_id=p.project_id
WHERE w.workpackage_id=$workpackage_id::INTEGER;

SET MaxDate = SELECT MAX(expense_invoice_date) 
FROM project_workpackage_expenses as e
LEFT JOIN (SELECT workpackage_id, workpackage_name, workpackage_type, project_id FROM project_workpackage) as w
ON e.workpackage_id=w.workpackage_id
LEFT JOIN (SELECT project_id, project_name FROM project) as p
ON w.project_id=p.project_id
WHERE w.workpackage_id=$workpackage_id::INTEGER;


SELECT 
    'chart'             as component,
    'bar'               as type,
    'green'             as color,
    'Répartition des coûts par mois' as title,
    TRUE                as labels;

WITH RECURSIVE dates(d) AS 
(
    SELECT $MinDate::DATE

    UNION ALL

    SELECT DATE(d + interval '1 month') 
    FROM dates
    WHERE d < $MaxDate::DATE
)

SELECT
    TO_CHAR(e.expense_invoice_date, 'YYYY-MM')  AS label,
    SUM(e.expense_value)                      AS value
FROM project_workpackage_expenses AS e
JOIN dates ON TO_CHAR(e.expense_invoice_date, 'YYYY-MM') = TO_CHAR( dates.d, 'YYYY-MM')
LEFT JOIN (SELECT workpackage_id, workpackage_name, workpackage_type, project_id FROM project_workpackage) as w
ON e.workpackage_id=w.workpackage_id

WHERE w.workpackage_id=$workpackage_id::INTEGER
GROUP BY label;
