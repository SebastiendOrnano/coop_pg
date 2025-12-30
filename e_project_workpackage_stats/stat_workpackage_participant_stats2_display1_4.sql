SELECT 
    'chart'             AS component,
    'bar'               AS type,
    TRUE                AS vertical,
    'Temps de travail cumulés pour les personnes physiques individuelles (PRM1)' AS title,
    'green'             AS color,
    TRUE                AS labels;
SELECT 
    i.prm1_first_name||' '||i.prm1_last_name AS label,
    'green' AS color,
    SUM(EXTRACT(EPOCH FROM s.worksequence_end_hour_scheduled - s.worksequence_start_hour_scheduled)) / 3600 AS value
    FROM prm1 AS i
    LEFT JOIN (SELECT worksequence_id, prm1_id, employee_id, worksequence_participant_type FROM project_worksequence_participants WHERE employee_id IS NULL) AS t 
    ON t.prm1_id = i.prm1_id
    LEFT JOIN (SELECT workpackage_id, worksequence_id, worksequence_end_hour_actual, worksequence_end_hour_scheduled, worksequence_nb_participants, worksequence_start_hour_actual, worksequence_start_hour_scheduled FROM project_worksequence) AS s 
    ON t.worksequence_id = s.worksequence_id
    LEFT JOIN (SELECT workpackage_id, project_id FROM project_workpackage) AS w 
    ON w.workpackage_id = s.workpackage_id
    WHERE w.workpackage_id=$workpackage_id::INTEGER
    GROUP BY i.prm1_id;