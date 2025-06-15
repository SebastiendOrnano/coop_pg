SET project_name = SELECT project_name FROM project WHERE project_id=$project_id::INTEGER;

SELECT
    'csv'              AS component,
    'Télécharger les heures travaillées sur le projet' AS title,
    'heures_sequence'    AS filename,
    'csv'              AS class,
    'file-download'    AS icon,
    'yellow'            AS color,
    ';'                AS separator,
    TRUE               AS bom;

SELECT
    s.worksequence_id                        AS wks_id,
    s.worksequence_name                      AS wks_name,
    w.workpackage_name                       AS wkp_name,
    s.worksequence_nb_participants           AS wks_nb_participants,
    s.worksequence_start_date_scheduled	     AS wks_start_date_scheduled,	
	s.worksequence_start_date_actual	     AS wks_start_date_actual,
	s.worksequence_start_hour_scheduled	     AS wks_start_hour_scheduled,
	s.worksequence_start_hour_actual         AS wks_start_hour_actual,
	s.worksequence_end_hour_scheduled        AS wks_end_hour_scheduled,
	s.worksequence_end_hour_actual           AS wks_end_hour_actual,
	s.worksequence_duration_scheduled	     AS wks_duration_scheduled,
	s.worksequence_duration_actual           AS wks_duration_actual,
	s.worksequence_completion_percentage	 AS wks_completion_percentage,
    EXTRACT(EPOCH FROM s.worksequence_end_hour_scheduled - s.worksequence_start_hour_scheduled) * s.worksequence_nb_participants / 3600 AS wks_scheduled_hours,
    EXTRACT(EPOCH FROM s.worksequence_end_hour_actual - s.worksequence_start_hour_actual) * s.worksequence_nb_participants / 3600  AS wks_actual_hours
FROM project_worksequence AS s
LEFT JOIN (SELECT workpackage_id, workpackage_name, project_id FROM project_workpackage) AS w
ON s.workpackage_id = w.workpackage_id
LEFT JOIN (SELECT project_id, project_name FROM project) AS p
ON p.project_id = w.project_id
WHERE p.project_id = $project_id::INTEGER AND s.worksequence_status='active';