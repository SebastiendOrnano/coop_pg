SELECT 
    'chart'             AS component,
    'pie'               AS type,
    TRUE                AS horizontal,
    'Répartition des temps de travail par type de travaux' AS title,
    'green'             AS color,
    TRUE                AS labels;
SELECT 
    s.worksequence_type AS label,
    SUM(EXTRACT(EPOCH FROM s.worksequence_end_hour_scheduled - s.worksequence_start_hour_scheduled)* s.worksequence_nb_participants) / 3600 AS value
    FROM project_worksequence AS s
    LEFT JOIN (SELECT workpackage_id, workpackage_name FROM project_workpackage) AS w 
    ON w.workpackage_id = s.workpackage_id
    WHERE w.workpackage_id=$workpackage_id::INTEGER
    GROUP BY s.worksequence_type;