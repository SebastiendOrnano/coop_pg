SET project_name = SELECT project_name FROM project WHERE project_id=$project_id::INTEGER;SET project_id = SELECT project_id FROM project_workpackage WHERE workpackage_id=$workpackage_id::INTEGER;
SET workpackage_name= SELECT workpackage_name FROM project_workpackage WHERE workpackage_id=$workpackage_id::INTEGER;
SET project_name= SELECT project_name FROM project WHERE project_id=$project_id::INTEGER;

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
    s.worksequence_id                        as wks_id,
    s.worksequence_name                      as wks_name,
    w.workpackage_id                         as wkp_id,
    w.workpackage_name                       as wkp_name,
    p.project_id                             as project_id,
    p.project_name                           as project_name,
    s.worksequence_nb_participants           as wks_nb_participants,
    s.worksequence_start_date_scheduled	     as wks_start_date_scheduled,	
	s.worksequence_start_date_actual	     as wks_start_date_actual,
	s.worksequence_start_hour_scheduled	     as wks_start_hour_scheduled,
	s.worksequence_start_hour_actual         as wks_start_hour_actual,
	s.worksequence_end_hour_scheduled        as wks_end_hour_scheduled,
	s.worksequence_end_hour_actual           as wks_end_hour_actual,
	s.worksequence_duration_scheduled	     as wks_duration_scheduled,
	s.worksequence_duration_actual           as wks_duration_actual,
	s.worksequence_completion_percentage	 as wks_completion_percentage,
    EXTRACT(EPOCH FROM s.worksequence_end_hour_scheduled - s.worksequence_start_hour_scheduled) / 3600  AS wks_scheduled_hours,
    EXTRACT(EPOCH FROM s.worksequence_end_hour_actual - s.worksequence_start_hour_actual) / 3600 AS wks_actual_hours
FROM project_worksequence as s
LEFT JOIN (SELECT workpackage_id, workpackage_name, project_id FROM project_workpackage) as w
ON s.workpackage_id = w.workpackage_id
LEFT JOIN (SELECT project_id, project_name FROM project) as p
ON p.project_id = w.project_id
WHERE w.workpackage_id=$workpackage_id::INTEGER AND s.worksequence_status='active';