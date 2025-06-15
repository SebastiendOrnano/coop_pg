SET user_id = (
    SELECT users.user_id  FROM users
    INNER JOIN sessions ON users.user_id = sessions.user_id
    WHERE sessions.session_token = sqlpage.cookie('session_token')
); 

SET user_role = (
    SELECT user_role FROM users
    INNER JOIN sessions ON users.user_id = sessions.user_id
    WHERE sessions.session_token = sqlpage.cookie('session_token')
); 


SET project_id=(SELECT project_id FROM project_meeting WHERE project_meeting_id=$project_meeting_id::INTEGER);


SET redirect_link =
CASE WHEN $user_role = 'supervisor' 
THEN '/e_project_meeting/project_meeting_main_display_4.sql?project_id='||$project_id
ELSE '/e_project_meeting/project_meeting_main_display_3.sql?project_id='||$project_id
END;

UPDATE project_meeting
SET
	project_meeting_title = :project_meeting_title,
	project_meeting_type =  :project_meeting_type,
	project_meeting_status = :project_meeting_status,
	project_meeting_visio = :project_meeting_visio,
	project_meeting_visio_url = :project_meeting_visio_url,
	project_meeting_visio_code = :project_meeting_visio_code,
	project_meeting_agenda = :project_meeting_agenda,
	project_meeting_place_id =
	CASE
	WHEN :project_meeting_place_id IS NULL OR :project_meeting_place_id = '' THEN NULL
	ELSE :project_meeting_place_id::INTEGER 
	END,
	project_meeting_date  =
	CASE
	WHEN :project_meeting_date IS NULL  OR :project_meeting_date = '' THEN NULL
	ELSE :project_meeting_date::DATE 
	END,
	project_meeting_hour_start =
	CASE
	WHEN :project_meeting_hour_start IS NULL  OR :project_meeting_hour_start = '' THEN NULL
	ELSE :project_meeting_hour_start::TIME 
	END,
	project_meeting_hour_end =
	CASE
	WHEN :project_meeting_hour_end IS NULL  OR :project_meeting_hour_end = ''THEN NULL
	ELSE :project_meeting_hour_end::TIME 
	END,
	project_meeting_duration =
	CASE
	WHEN :project_meeting_duration IS NULL  OR :project_meeting_duration = ''THEN NULL
	ELSE :project_meeting_duration::TIME 
	END,
    project_meeting_alert = :project_meeting_alert,
    updated_at=CURRENT_TIMESTAMP
WHERE project_meeting_id = $project_meeting_id::INTEGER

RETURNING 'redirect' AS component,
 $redirect_link AS link;


