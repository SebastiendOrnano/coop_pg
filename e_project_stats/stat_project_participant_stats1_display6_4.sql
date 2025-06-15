
SET duration_scheduled = 
(
    SELECT
    SUM(EXTRACT(EPOCH FROM s.worksequence_end_hour_scheduled - s.worksequence_start_hour_scheduled) * s.worksequence_nb_participants) / 3600
    FROM project_worksequence AS s
    LEFT JOIN project_workpackage AS w ON w.workpackage_id = s.workpackage_id
    LEFT JOIN project AS p ON w.project_id = p.project_id
    WHERE p.project_id = $project_id::INTEGER
);

SET duration_actual = 
    (
    SELECT
    SUM( EXTRACT(EPOCH FROM s.worksequence_end_hour_actual - s.worksequence_start_hour_actual)* s.worksequence_nb_participants) / 3600
    FROM project_worksequence AS s
    LEFT JOIN (SELECT workpackage_id, project_id FROM project_workpackage) AS w 
    ON w.workpackage_id = s.workpackage_id
    LEFT JOIN (SELECT project_id FROM project) AS p
    ON w.project_id = p.project_id
    WHERE p.project_id=$project_id::INTEGER
    );



SELECT 
    'chart'             AS component,
    'bar'               AS type,
    TRUE                AS vertical,
    'Répartition des temps de travail réel par lot de travaux' AS title,
    'red'               AS color,
    TRUE                AS labels;
SELECT 
    '(actual)    '||w.workpackage_name AS label,
    SUM(EXTRACT(EPOCH FROM s.worksequence_end_hour_actual - s.worksequence_start_hour_actual)* s.worksequence_nb_participants) / 3600 AS value
    FROM project_worksequence AS s
    LEFT JOIN (SELECT workpackage_id, workpackage_name, project_id FROM project_workpackage) AS w 
    ON w.workpackage_id = s.workpackage_id
    LEFT JOIN (SELECT project_id FROM project) AS p
    ON w.project_id = p.project_id
    WHERE p.project_id=$project_id::INTEGER
    GROUP BY w.workpackage_name;
