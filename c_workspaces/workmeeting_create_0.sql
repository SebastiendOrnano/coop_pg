SET user_id = (
    SELECT u.user_id  FROM users as u
    LEFT JOIN (SELECT session_id, user_id, session_token FROM sessions) as s
    ON s.user_id = u.user_id
    WHERE s.session_token = sqlpage.cookie('session_token')
);

SET user_role = (
    SELECT user_role FROM users
    INNER JOIN sessions ON users.user_id = sessions.user_id
    WHERE sessions.session_token = sqlpage.cookie('session_token')
); 

SET redirect_link =
CASE WHEN $user_role = 'supervisor' 
THEN '/c_workspaces/workspace_hub_display_4.sql?workspace_id='||$workspace_id
ELSE '/c_workspaces/workspace_hub_display_3.sql?workspace_id='||$workspace_id
END;

INSERT INTO workmeetings
(
    workspace_id,
	workmeeting_title,
	workmeeting_type,
	workmeeting_status,
	workmeeting_visio,
	workmeeting_visio_url,
	workmeeting_visio_code,
	space_id,
	workmeeting_agenda,
	workmeeting_date,
	workmeeting_hour_start,
	workmeeting_hour_end,
	workmeeting_duration
)
VALUES 
(
    $workspace_id::INTEGER,
	:workmeeting_title,
	:workmeeting_type,
	:workmeeting_status,
	:workmeeting_visio,
	:workmeeting_visio_url,
	:workmeeting_visio_code,
	COALESCE(NULLIF(:space_id, ''), NULL)::INTEGER,
	:workmeeting_agenda,
	COALESCE(NULLIF(:workmeeting_date, ''), NULL)::DATE,
	COALESCE(NULLIF(:workmeeting_hour_start, ''), NULL)::TIME,
	COALESCE(NULLIF(:workmeeting_hour_end, ''), NULL)::TIME,
	COALESCE(NULLIF(:workmeeting_duration, ''), NULL)::TIME
);

SET workmeeting_id = (SELECT MAX(workmeeting_id) FROM workmeetings WHERE workmeeting_title=:workmeeting_title AND workmeeting_date=:workmeeting_date::DATE);

INSERT INTO workmeeting_participants
(
workmeeting_id,
workspace_id,
user_id,
workmeeting_participant_status,
workmeeting_participant_role
)
VALUES 
(
$workmeeting_id::INTEGER,
$workspace_id::INTEGER,
$user_id::INTEGER,
'active',
'coordinator'
);

UPDATE workmeetings
SET
workmeeting_participants_nb=workmeeting_participants_nb+1,
updated_at=CURRENT_TIMESTAMP
WHERE workmeeting_id=$workmeeting_id::INTEGER

RETURNING 'redirect' AS component,
 $redirect_link AS link;


