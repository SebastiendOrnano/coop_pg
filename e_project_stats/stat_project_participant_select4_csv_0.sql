SELECT
    'csv'              AS component,
    'Télécharger les heures travaillées sur le projet' AS title,
    'heures_groupe_select'    AS filename,
    'csv'              AS class,
    'file-download'    AS icon,
    'yellow'            AS color,
    ';'                AS separator,
    TRUE               AS bom;

SELECT
    t.worksequence_participant_id            AS participant_id,
    i.prm3_id                                AS prm3_id,
    i.prm3_name                              AS nom,
    s.worksequence_id                        AS wks_id,
    s.worksequence_name                      AS wks_name,
    w.workpackage_id                         AS wkp_id,
    w.workpackage_name                       AS wkp_name,
    s.worksequence_start_date_scheduled	     AS wks_start_date_scheduled,	
	s.worksequence_start_date_actual	     AS wks_start_date_actual,
	s.worksequence_start_hour_scheduled	     AS wks_start_hour_scheduled,
	s.worksequence_start_hour_actual         AS wks_start_hour_actual,
	s.worksequence_end_hour_scheduled        AS wks_end_hour_scheduled,
	s.worksequence_end_hour_actual           AS wks_end_hour_actual,
	s.worksequence_duration_scheduled	     AS wks_duration_scheduled,
    EXTRACT(EPOCH FROM s.worksequence_end_hour_scheduled - s.worksequence_start_hour_scheduled) / 3600  AS wks_scheduled_hours,
    EXTRACT(EPOCH FROM s.worksequence_end_hour_actual - s.worksequence_start_hour_actual) / 3600 AS wks_actual_hours
FROM project_worksequence_participants AS t

LEFT JOIN (SELECT prm3_id, prm3_name FROM prm3) AS i
ON t.prm3_id = i.prm3_id

LEFT JOIN (SELECT worksequence_id, worksequence_name, workpackage_id, worksequence_start_date_scheduled, worksequence_start_date_actual, worksequence_start_hour_scheduled, worksequence_start_hour_actual, worksequence_end_hour_scheduled, worksequence_end_hour_actual, worksequence_duration_scheduled, worksequence_status  FROM project_worksequence) AS s
ON t.worksequence_id = s.worksequence_id

LEFT JOIN (SELECT workpackage_id, workpackage_name, project_id FROM project_workpackage) AS w
ON s.workpackage_id = w.workpackage_id

LEFT JOIN (SELECT project_id, project_name FROM project) AS p
ON p.project_id = w.project_id

WHERE t.prm3_id=:prm3_id::INTEGER AND p.project_id = $project_id::INTEGER AND s.worksequence_status='active' ;