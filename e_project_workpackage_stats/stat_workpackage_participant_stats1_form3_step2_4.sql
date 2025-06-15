SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SELECT 
    'breadcrumb' as component;
set project_id = SELECT project_id FROM project_workpackage WHERE workpackage_id=$workpackage_id::INTEGER;

SELECT 
    'breadcrumb' as component;
SELECT 
    'Home' as title,
    '/'    as link;
SELECT 
    'Gestion Superviseur'         as title,
    '/a_panels/panel_supervisor_4.sql' as link;
 SELECT 
    'Hub du projet'            as title,
    '/e_project/project_hub_display_4.sql?project_id='||$project_id      as link;
 SELECT 
    'Hub du lot de travaux'            as title,
    '/e_project_workpackage/workpackage_hub_display_4.sql?workpackage_id='||$workpackage_id    as link; 

SELECT 
    'form'      AS component,
    'Choisir un participant individuel' as validate,
    '/e_project_workpackage_stats/stat_workpackage_workhours_participant3_csv_0.sql?workpackage_id='||$workpackage_id AS action;

SELECT 
   'employee_id' AS name,
    'Nom de l''employé' AS label,
    'select' AS type,
    8 AS width,
    TRUE AS searchable,
    'Saisissez quelques lettres du nom que vous cherchez ou choississez dans la liste' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label', i.prm1_last_name || '   ' || i.prm1_first_name, 'value',e.employee_id)ORDER BY i.prm1_last_name ASC) AS options
    FROM prm1 AS i
    LEFT JOIN (SELECT employee_id, prm1_id, prm2_sub_id FROM prm2_sub_employees) AS e
    on e.prm1_id=i.prm1_id
    LEFT JOIN (SELECT worksequence_id, employee_id FROM project_worksequence_participants) AS t
    on t.employee_id=e.employee_id
    LEFT JOIN (SELECT worksequence_id, workpackage_id, worksequence_status  FROM project_worksequence) AS s
    ON t.worksequence_id = s.worksequence_id
    LEFT JOIN (SELECT workpackage_id, workpackage_name, project_id FROM project_workpackage) AS w
    ON s.workpackage_id = w.workpackage_id
    WHERE  w.workpackage_id = $workpackage_id::INTEGER AND s.worksequence_status='active' AND e.prm2_sub_id=:prm2_sub_id::INTEGER;
