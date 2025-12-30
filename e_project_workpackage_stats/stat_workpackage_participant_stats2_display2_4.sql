SELECT 
    'chart'             AS component,
    'bar'               AS type,
    TRUE                AS vertical,
    'Temps de travail cumulés pour les entreprises (PRM2) sur le lot de travaux' AS title,
    'blue'             AS color,
    TRUE                AS labels;
SELECT 
    i.prm2_sub_name AS label,
    'blue' AS color,
   SUM(EXTRACT(EPOCH FROM s.worksequence_end_hour_scheduled - s.worksequence_start_hour_scheduled)) / 3600  AS value
    FROM prm2_sub AS i
    
    LEFT JOIN (SELECT worksequence_id, prm2_sub_id, worksequence_participant_type FROM project_worksequence_participants) AS p 
    ON p.prm2_sub_id = i.prm2_sub_id
    LEFT JOIN (SELECT workpackage_id, worksequence_id, worksequence_end_hour_actual, worksequence_end_hour_scheduled, worksequence_nb_participants, worksequence_start_hour_actual, worksequence_start_hour_scheduled FROM project_worksequence) AS s 
    ON p.worksequence_id = s.worksequence_id
    LEFT JOIN (SELECT workpackage_id, project_id FROM project_workpackage) AS w 
    ON w.workpackage_id = s.workpackage_id
    WHERE w.workpackage_id=$workpackage_id::INTEGER AND  worksequence_participant_type='corporate'
    GROUP BY i.prm2_sub_id;