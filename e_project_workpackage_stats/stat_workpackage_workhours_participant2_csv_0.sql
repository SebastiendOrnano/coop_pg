SELECT
    'csv'              as component,
    'Télécharger les heures travaillées sur le projet' as title,
    'heures_travail_projet'    as filename,
    'csv'              as class,
    'file-download'    as icon,
    'yellow'            as color,
    ';'                as separator,
    TRUE               as bom;

SELECT
    i.prm2_sub_id                            AS prm2_sub_id,
    i.prm2_sub_name                          AS nom,
    s.worksequence_id                        AS wks_id,
    s.worksequence_name                      AS wks_name,
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

LEFT JOIN (SELECT prm2_sub_id, prm2_sub_name FROM prm2_sub) AS i
on t.prm2_sub_id=i.prm2_sub_id

LEFT JOIN (SELECT 
worksequence_id, 
worksequence_name, 
workpackage_id, 
worksequence_start_date_scheduled, 
worksequence_start_date_actual,
worksequence_start_hour_scheduled,
worksequence_start_hour_actual,
worksequence_end_hour_scheduled,
worksequence_end_hour_actual,
worksequence_duration_scheduled,
worksequence_duration_actual,
worksequence_completion_percentage, 
worksequence_status
FROM project_worksequence) AS s
ON s.worksequence_id = t.worksequence_id

LEFT JOIN (SELECT workpackage_id, workpackage_name, project_id FROM project_workpackage) AS w
ON s.workpackage_id = w.workpackage_id

WHERE w.workpackage_id = $workpackage_id::INTEGER  AND t.prm2_sub_id=:prm2_sub_id::INTEGER AND s.worksequence_status='active' AND t.employee_id IS NULL;