SELECT 
    'chart'             AS component,
    'pie'               AS type,
    TRUE                AS horizontal,
    'Répartition réelle des temps de travail par type d''intervenant' AS title,
    'green'             AS color,
    TRUE                AS labels;
SELECT 
    t.worksequence_participant_type AS label,
    SUM(EXTRACT(EPOCH FROM s.worksequence_end_hour_actual - s.worksequence_start_hour_actual)* s.worksequence_nb_participants) / 3600 AS value
    FROM project_worksequence_participants AS t
    LEFT JOIN (SELECT worksequence_id,workpackage_id, worksequence_name, worksequence_end_hour_actual, worksequence_start_hour_actual,worksequence_nb_participants FROM project_worksequence) AS s 
    ON t.worksequence_id = s.worksequence_id
    LEFT JOIN (SELECT workpackage_id, workpackage_name, workpackage_mode, project_id FROM project_workpackage) AS w 
    ON w.workpackage_id = s.workpackage_id
    LEFT JOIN (SELECT project_id FROM project) AS p
    ON w.project_id = p.project_id
    WHERE p.project_id=$project_id::INTEGER
    GROUP BY t.worksequence_participant_type ;