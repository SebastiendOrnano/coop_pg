

SET user_id = (
    SELECT u.user_id  FROM users as u
    LEFT JOIN (SELECT session_id, user_id, session_token FROM sessions) as s
    ON s.user_id = u.user_id
    WHERE s.session_token = sqlpage.cookie('session_token')

);SET user_role = (
    SELECT user_role FROM users
    INNER JOIN sessions ON users.user_id = sessions.user_id
    WHERE sessions.session_token = sqlpage.cookie('session_token')
); 

SET workspace_id=(SELECT workspace_id FROM workmeetings WHERE workmeeting_id=$workmeeting_id::INTEGER);

SET redirect_link =
CASE WHEN $user_role = 'supervisor' 
THEN '/c_workspaces/workspace_hub_display_4.sql?workspace_id='||$workspace_id
ELSE '/c_workspaces/workspace_hub_display_3.sql?workspace_id='||$workspace_id
END;

UPDATE workmeetings
SET
	workmeeting_title = :workmeeting_title,
	workmeeting_type =  :workmeeting_type,
	workmeeting_status = :workmeeting_status,
	workmeeting_visio = :workmeeting_visio,
	workmeeting_visio_url = :workmeeting_visio_url,
	workmeeting_visio_code = :workmeeting_visio_code,
	space_id = COALESCE(NULLIF(:space_id, ''), NULL)::INTEGER,
	workmeeting_agenda = :workmeeting_agenda,
	workmeeting_date = COALESCE(NULLIF(:workmeeting_date, ''), NULL)::DATE,
	workmeeting_hour_start = COALESCE(NULLIF(:workmeeting_hour_start, ''), NULL)::TIME,
	workmeeting_hour_end = COALESCE(NULLIF(:workmeeting_hour_end, ''), NULL)::TIME,
	workmeeting_duration =COALESCE(NULLIF(:workmeeting_duration, ''), NULL)::TIME,
    workmeeting_alert = :workmeeting_alert,
    updated_at=CURRENT_TIMESTAMP
WHERE workmeeting_id = $workmeeting_id::INTEGER

RETURNING 'redirect' AS component,
 $redirect_link AS link;


