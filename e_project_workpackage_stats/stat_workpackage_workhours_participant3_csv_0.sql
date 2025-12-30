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
    e.employee_id                            AS employee_id,
    i.prm1_id                                AS prm1_id,
    i.prm1_first_name                        AS prenom,
    i.prm1_last_name                         AS nom,
    c.prm2_sub_name                          AS Compagny,
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

LEFT JOIN (SELECT  employee_id, prm1_id, prm2_sub_id FROM prm2_sub_employees) AS e
ON t.employee_id=e.employee_id

LEFT JOIN (SELECT  prm1_id, prm1_first_name, prm1_last_name FROM prm1) AS i
on e.prm1_id=i.prm1_id

LEFT JOIN (SELECT  prm2_sub_id, prm2_sub_name FROM prm2_sub) AS c
on c.prm2_sub_id=e.prm2_sub_id

LEFT JOIN (SELECT worksequence_id, worksequence_name, workpackage_id, worksequence_start_date_scheduled, worksequence_start_date_actual, worksequence_start_hour_scheduled, worksequence_start_hour_actual, worksequence_end_hour_scheduled, worksequence_end_hour_actual, worksequence_duration_scheduled, worksequence_status  FROM project_worksequence) AS s
ON t.worksequence_id = s.worksequence_id

LEFT JOIN (SELECT workpackage_id, workpackage_name, project_id FROM project_workpackage) AS w
ON s.workpackage_id = w.workpackage_id

WHERE e.employee_id=:employee_id::INTEGER AND w.workpackage_id = $workpackage_id::INTEGER AND s.worksequence_status='active' ;