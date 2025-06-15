SELECT
    'csv'              AS component,
    'Télécharger temps de travail d''un participant' AS title,
    'heures_participants'           AS filename,
    'csv'                            AS class,
    'file-download'                  AS icon,
    'yellow'                         AS color,
    ';'                              AS separator,
    TRUE                             AS bom;

SELECT
    t.worksequence_participant_id            AS participant_id,
    i.prm1_first_name                        AS prenom,
    i.prm1_last_name                         AS Nom,
    c.prm2_sub_id                            AS SudId,
    c.prm2_sub_name                          AS Compagny,
    g.prm3_id                                AS TeamId,
    g.prm3_name                              AS Team,
    s.worksequence_id                        AS wks_id,
    s.worksequence_name                      AS wks_name,
    s.workpackage_id                         AS wkp_id,
    w.workpackage_name                       AS wkp_name,
    s.worksequence_start_date_scheduled	     AS wks_start_date_scheduled,	
	s.worksequence_start_date_actual	     AS wks_start_date_actual,
	s.worksequence_start_hour_scheduled	     AS wks_start_hour_scheduled,
	s.worksequence_start_hour_actual         AS wks_start_hour_actual,
	s.worksequence_end_hour_scheduled        AS wks_end_hour_scheduled,
	s.worksequence_end_hour_actual           AS wks_end_hour_actual,
	s.worksequence_duration_scheduled	     AS wks_duration_scheduled,
	s.worksequence_duration_actual           AS wks_duration_actual,
	s.worksequence_completion_percentage	 AS wks_completion_percentage,
    EXTRACT(EPOCH FROM s.worksequence_end_hour_scheduled - s.worksequence_start_hour_scheduled) / 3600  AS wks_scheduled_hours,
    EXTRACT(EPOCH FROM s.worksequence_end_hour_actual - s.worksequence_start_hour_actual) / 3600 AS wks_actual_hours
FROM project_worksequence_participants AS t

LEFT JOIN (SELECT prm1_id, prm1_first_name, prm1_last_name FROM prm1) AS i
ON t.prm1_id = i.prm1_id

LEFT JOIN (SELECT prm2_sub_id, prm2_sub_name FROM prm2_sub) AS c
on t.prm2_sub_id=c.prm2_sub_id

LEFT JOIN (SELECT prm3_id, prm3_name FROM prm3) AS g
ON t.prm3_id = g.prm3_id

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

LEFT JOIN (SELECT project_id, project_name FROM project) AS p
ON p.project_id = w.project_id

WHERE p.project_id = $project_id::INTEGER  AND s.worksequence_status='active';
