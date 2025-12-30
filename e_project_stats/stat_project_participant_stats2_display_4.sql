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
    'chart'             AS component,
    'bar'               AS type,
    TRUE                AS horizontal,
    'Temps de travail cumulés pour les personnes physiques individuelles (PRM1) sur le projet : '||$project_name AS title,
    'green'             AS color,
    TRUE                AS labels;
SELECT 
    i.prm1_first_name||' '||i.prm1_last_name AS label,
    'green' AS color,
    SUM(EXTRACT(EPOCH FROM s.worksequence_end_hour_actual - s.worksequence_start_hour_actual) * s.worksequence_nb_participants) / 3600 AS value
    FROM prm1 AS i
    LEFT JOIN (SELECT worksequence_id, prm1_id FROM project_worksequence_participants) AS p 
    ON p.prm1_id = i.prm1_id
    LEFT JOIN (SELECT workpackage_id, worksequence_id, worksequence_end_hour_actual, worksequence_nb_participants, worksequence_start_hour_actual FROM project_worksequence) AS s 
    ON p.worksequence_id = s.worksequence_id
    LEFT JOIN (SELECT workpackage_id, project_id FROM project_workpackage) AS w 
    ON w.workpackage_id = s.workpackage_id
    WHERE w.project_id=$project_id::INTEGER
    GROUP BY i.prm1_first_name||' '||i.prm1_last_name;

SELECT 
    'chart'             AS component,
    'bar'               AS type,
    TRUE                AS horizontal,
    'Temps de travail cumulés pour les entreprises (PRM2) sur le projet : '||$project_name AS title,
    'blue'             AS color,
    TRUE                AS labels;
SELECT 
    i.prm2_sub_name AS label,
    'blue' AS color,
    SUM(EXTRACT(EPOCH FROM s.worksequence_end_hour_actual - s.worksequence_start_hour_actual) * s.worksequence_nb_participants) / 3600  AS value
    FROM prm2_sub AS i
    LEFT JOIN (SELECT worksequence_id, prm2_sub_id FROM project_worksequence_participants) AS p 
    ON p.prm2_sub_id = i.prm2_sub_id
    LEFT JOIN (SELECT workpackage_id, worksequence_id, worksequence_end_hour_actual,worksequence_nb_participants, worksequence_start_hour_actual FROM project_worksequence) AS s 
    ON p.worksequence_id = s.worksequence_id
    LEFT JOIN (SELECT workpackage_id, project_id FROM project_workpackage) AS w 
    ON w.workpackage_id = s.workpackage_id
    WHERE w.project_id=$project_id::INTEGER
    GROUP BY i.prm2_sub_name;

SELECT 
    'chart'             AS component,
    'bar'               AS type,
    TRUE                AS horizontal,
    'Temps de travail cumulés pour les groupes (PRM3) sur le projet : '||$project_name AS title,
    'red'             AS color,
    TRUE                AS labels;
SELECT 
    i.prm3_name AS label,
    'red' AS color,
    SUM(EXTRACT(EPOCH FROM s.worksequence_end_hour_actual - s.worksequence_start_hour_actual) * s.worksequence_nb_participants) / 3600 AS value
    FROM prm3 AS i
    LEFT JOIN (SELECT worksequence_id, prm3_id FROM project_worksequence_participants) AS p ON p.prm3_id = i.prm3_id
    LEFT JOIN (SELECT workpackage_id, worksequence_id, worksequence_end_hour_actual,worksequence_nb_participants, worksequence_start_hour_actual FROM project_worksequence) AS s 
    ON p.worksequence_id = s.worksequence_id
    LEFT JOIN (SELECT workpackage_id, project_id FROM project_workpackage) AS w 
    ON w.workpackage_id = s.workpackage_id
    WHERE w.project_id=$project_id::INTEGER
    GROUP BY i.prm3_name;