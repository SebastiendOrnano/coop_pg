SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SET project_id = SELECT project_id FROM project_workpackage WHERE workpackage_id = $workpackage_id::INTEGER ;
SET workpackage_name = SELECT workpackage_name FROM project_workpackage  WHERE workpackage_id = $workpackage_id::INTEGER ;
SET project_name = SELECT project_name FROM project WHERE project_id =$project_id::INTEGER 

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
    'Hub du projet'            as title,
    '/e_project/project_hub_display_4.sql?project_id='||$project_id     as link;   
 SELECT 
    'Hub lot de travaux'            as title,
    '/e_project_workpackage/workpackage_hub_display_4.sql?workpackage_id='||$workpackage_id   as link;   


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
    'Nom du projet de rattachement' as label,
    5 as width,
    $project_name as value;
SELECT
    'workpackage_id' as name,
    TRUE as readonly,
    'Id wkp ' as label,
    1 as width,
   $workpackage_id as value;
SELECT
    'workpackage_name' as name,
    TRUE as readonly,
    'Nom du lot de travaux' as label,
    5 as width,
    $workpackage_name as value;

SET date_start_mini = 
SELECT MIN(s.worksequence_start_date_scheduled) FROM project_worksequence as s
LEFT JOIN (SELECT workpackage_id, workpackage_name,  project_id FROM project_workpackage) as w 
on s.workpackage_id=w.workpackage_id
LEFT JOIN (SELECT project_id FROM project) as p 
on p.project_id=w.project_id
WHERE p.project_id=$project_id::INTEGER;


SET date_start_max = 
SELECT MAX(s.worksequence_start_date_actual) FROM project_worksequence as s
LEFT JOIN (SELECT workpackage_id, workpackage_name,  project_id FROM project_workpackage) as w 
on s.workpackage_id = w.workpackage_id
LEFT JOIN (SELECT project_id FROM project) as p 
on p.project_id=w.project_id
WHERE p.project_id=$project_id::INTEGER;

SELECT 
    'chart'            as component,
    'Worksquences Timeline' as title,
    'rangeBar'         as type,
    TRUE               as time,
    'green'             as color,
    'blue'             as color,
    $date_start_mini   as xmin,
    $date_start_max    as xmax;

SELECT 
    s.worksequence_name                       as series,
    s.worksequence_name  ||'    Planififié'    as label,
    CONCAT (s.worksequence_start_date_scheduled,' ',s.worksequence_start_hour_scheduled)    as value,
    CONCAT (s.worksequence_start_date_scheduled,' ',s.worksequence_end_hour_scheduled)     as value
  FROM project_worksequence as s
  WHERE s.workpackage_id=$workpackage_id::INTEGER;

SELECT 
    s.worksequence_name                       as series,
    s.worksequence_name  ||'    Réel'    as label,
    CONCAT (s.worksequence_start_date_actual,' ',s.worksequence_start_hour_actual)    as value,
    CONCAT (s.worksequence_start_date_actual,' ',s.worksequence_end_hour_actual)     as value
  FROM project_worksequence as s
  WHERE s.workpackage_id=$workpackage_id::INTEGER;
