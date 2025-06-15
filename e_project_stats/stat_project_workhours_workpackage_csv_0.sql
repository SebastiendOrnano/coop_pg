SET project_name = SELECT project_name FROM project WHERE project_id=$project_id::INTEGER;

SELECT
    'csv'              AS component,
    'Télécharger les heures travaillées sur le projet' AS title,
    'heures_workpackage'    AS filename,
    'csv'              AS class,
    'file-download'    AS icon,
    'yellow'            AS color,
    ';'                AS separator,
    TRUE               AS bom;

SELECT
    s.workpackage_id                        AS wkp_id,
    w.workpackage_name                       AS wkp_name,
    SUM(EXTRACT(EPOCH FROM s.worksequence_end_hour_scheduled - s.worksequence_start_hour_scheduled)* s.worksequence_nb_participants) / 3600 AS wkp_scheduled_hours,
    SUM(EXTRACT(EPOCH FROM s.worksequence_end_hour_actual - s.worksequence_start_hour_actual)* s.worksequence_nb_participants) / 3600 AS wkp_actual_hours
FROM project_worksequence AS s
LEFT JOIN (SELECT workpackage_id, workpackage_name, project_id FROM project_workpackage) AS w
ON s.workpackage_id = w.workpackage_id
LEFT JOIN (SELECT project_id, project_name FROM project) AS p
ON p.project_id = w.project_id
WHERE p.project_id = $project_id::INTEGER AND s.worksequence_status='active'
GROUP BY s.workpackage_id, w.workpackage_name;