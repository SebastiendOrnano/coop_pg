
SELECT 
    'chart'             AS component,
    'bar'               AS type,
      TRUE                AS vertical,
    'Temps de travail cumulés pour les employé (PRM2-sub-employés) sur le lot de travaux' AS title,
    'yellow'             AS color,
    TRUE                AS labels;
SELECT 
    i.prm1_first_name||' '||i.prm1_last_name||'--'||c.prm2_sub_name AS label,
    'green' AS color,
     SUM(EXTRACT(EPOCH FROM s.worksequence_end_hour_scheduled - s.worksequence_start_hour_scheduled)) / 3600 AS value
    FROM project_worksequence_participants  AS t 
    LEFT JOIN (SELECT prm2_sub_id, prm1_id, employee_id FROM prm2_sub_employees) AS e
    ON t.employee_id=e.employee_id
    LEFT JOIN (SELECT prm2_sub_id, prm2_sub_name FROM prm2_sub) AS c
    ON c.prm2_sub_id=e.prm2_sub_id
    LEFT JOIN (SELECT prm1_id, prm1_first_name, prm1_last_name FROM prm1) AS i
    ON i.prm1_id=e.prm1_id
    LEFT JOIN (SELECT workpackage_id, worksequence_id, worksequence_end_hour_actual, worksequence_end_hour_scheduled, worksequence_nb_participants, worksequence_start_hour_actual, worksequence_start_hour_scheduled FROM project_worksequence) AS s 
    ON t.worksequence_id = s.worksequence_id
    LEFT JOIN (SELECT workpackage_id, project_id FROM project_workpackage) AS w 
    ON w.workpackage_id = s.workpackage_id
    WHERE w.workpackage_id=$workpackage_id::INTEGER AND t.employee_id IS NOT NULL
    GROUP BY i.prm1_first_name,i.prm1_last_name , c.prm2_sub_name ;
