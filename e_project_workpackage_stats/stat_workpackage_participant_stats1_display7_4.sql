
SET duration_scheduled = 
(
    SELECT
    SUM(EXTRACT(EPOCH FROM s.worksequence_end_hour_scheduled - s.worksequence_start_hour_scheduled) * s.worksequence_nb_participants) / 3600
    FROM project_worksequence AS s
    LEFT JOIN (SELECT workpackage_id FROM project_workpackage) AS w 
    ON w.workpackage_id = s.workpackage_id
    WHERE w.workpackage_id = $workpackage_id::INTEGER
);

SET duration_actual = 
    (
    SELECT
    SUM( EXTRACT(EPOCH FROM s.worksequence_end_hour_actual - s.worksequence_start_hour_actual)* s.worksequence_nb_participants) / 3600
    FROM project_worksequence AS s
    LEFT JOIN (SELECT workpackage_id FROM project_workpackage) AS w 
    ON w.workpackage_id = s.workpackage_id
    WHERE w.workpackage_id = $workpackage_id::INTEGER
    );

SELECT 
    'chart'             AS component,
    'bar'               AS type,
    TRUE                AS vertical,
    'Répartition des temps de travail prévu par sequence' AS title,
    'red'               AS color,
    TRUE                AS labels;
SELECT 
    '(scheduled)    '||s.worksequence_name AS label,
    SUM(EXTRACT(EPOCH FROM s.worksequence_end_hour_scheduled - s.worksequence_start_hour_scheduled)* s.worksequence_nb_participants) / 3600 AS value
    FROM project_worksequence AS s
    LEFT JOIN (SELECT workpackage_id, workpackage_name FROM project_workpackage) AS w 
    ON w.workpackage_id = s.workpackage_id
    WHERE w.workpackage_id=$workpackage_id::INTEGER
    GROUP BY s.worksequence_name;
