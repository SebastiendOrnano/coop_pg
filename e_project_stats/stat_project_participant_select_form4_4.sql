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

SET project_name= SELECT project_name FROM project WHERE project_id=$project_id::INTEGER;


SELECT 
    'form'      AS component,
    'Choisir un groupe' AS validate,
    '/e_project_stats/stat_project_participant_select4_csv_0.sql?project_id='||$project_id AS action;

SELECT 
   'prm3_id' AS name,
    'Nom du groupe' AS label,
    'select' AS type,
    8 AS width,
    TRUE AS searchable,
    'Saisissez quelques lettres du nom que vous cherchez ou choississez dans la liste' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label', i.prm3_name, 'value', i.prm3_id)) AS options
    FROM prm3 AS i
    LEFT JOIN (SELECT worksequence_id, prm3_id FROM project_worksequence_participants) AS t
    on t.prm3_id=i.prm3_id
    LEFT JOIN (SELECT worksequence_id, worksequence_name, workpackage_id, worksequence_start_date_scheduled, worksequence_start_date_actual, worksequence_start_hour_scheduled, worksequence_start_hour_actual, worksequence_end_hour_scheduled, worksequence_end_hour_actual, worksequence_duration_scheduled, worksequence_status  FROM project_worksequence) AS s
    ON t.worksequence_id = s.worksequence_id
    LEFT JOIN (SELECT workpackage_id, workpackage_name, project_id FROM project_workpackage) AS w
    ON s.workpackage_id = w.workpackage_id
    LEFT JOIN (SELECT project_id, project_name FROM project) AS p
    ON p.project_id = w.project_id
    WHERE p.project_id = $project_id::INTEGER AND s.worksequence_status='active'
    GROUP BY i.prm3_id, i.prm3_name;
