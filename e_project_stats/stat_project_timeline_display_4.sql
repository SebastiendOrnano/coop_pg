SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SET project_name = SELECT project_name FROM project WHERE project_id =$project_id::INTEGER 

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
    'Id proj.' AS label,
    1 AS width,
   $project_id AS value;
SELECT
    'project_name' AS name,
    TRUE AS readonly,
    'Nom du projet' AS label,
    5 AS width,
    $project_name AS value;

SET date_start_mini =
SELECT MIN(w.workpackage_date_start_scheduled) FROM project_workpackage AS w
LEFT JOIN (SELECT project_id FROM project) AS p 
on p.project_id=w.project_id
WHERE p.project_id=$project_id::INTEGER;

SET date_end_max =
SELECT 
    CASE
        WHEN MAX(w.workpackage_date_end_actual) IS NOT NULL AND MAX(w.workpackage_date_end_actual) > MAX(w.workpackage_date_end_scheduled)
        THEN MAX(w.workpackage_date_end_actual) 
        ELSE MAX(w.workpackage_date_end_scheduled) 
    END
FROM project_workpackage AS w
LEFT JOIN (SELECT project_id FROM project) AS p 
ON p.project_id = w.project_id
WHERE p.project_id = $project_id::INTEGER;

SELECT 
    'chart'            AS component,
    'Workpackage Timeline' AS title,
    'rangeBar'         AS type,
    TRUE               AS time,
    'green'            AS color,
    'blue'             AS color,
    $date_start_mini   AS xmin,
    $date_end_max      AS xmax;

SELECT 
    w.workpackage_name                       AS series,
    w.workpackage_name  ||'    Planififié'    AS label,
    w.workpackage_date_start_scheduled        AS value,
    w.workpackage_date_end_scheduled          AS value
  FROM project_workpackage AS w
  left join (SELECT project_id FROM project) AS p
  on w.project_id=p.project_id
  WHERE p.project_id=$project_id::INTEGER
  ORDER BY w.workpackage_date_start_scheduled ASC;

SELECT 
    w.workpackage_name                       AS series,
    w.workpackage_name  ||'    Réel'         AS label,
    w.workpackage_date_start_actual      AS value,
    w.workpackage_date_end_actual         AS value
FROM project_workpackage AS w
left join (SELECT project_id FROM project) AS p
on w.project_id=p.project_id
WHERE p.project_id=$project_id::INTEGER AND w.workpackage_date_start_actual IS NOT NULL AND w.workpackage_date_end_actual IS NOT NULL;

