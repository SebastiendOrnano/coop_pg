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

SET redirect_link =
CASE WHEN $user_role = 'supervisor' 
THEN '/e_project_meeting/project_meeting_main_display_4.sql?project_id='||$project_id
ELSE '/e_project_meeting/project_meeting_main_display_3.sql?project_id='||$project_id
END;

INSERT INTO project_meeting
(
    project_id,
	project_meeting_title,
	project_meeting_type,
	project_meeting_status,
	project_meeting_visio,
	project_meeting_visio_url,
	project_meeting_visio_code,
	project_meeting_place_id,
	project_meeting_agenda,
	project_meeting_date,
	project_meeting_hour_start,
	project_meeting_hour_end,
	project_meeting_duration
)
VALUES 
(
    $project_id::INTEGER,
	:project_meeting_title,
	:project_meeting_type,
	:project_meeting_status,
	:project_meeting_visio,
	:project_meeting_visio_url,
	:project_meeting_visio_code,
	COALESCE(NULLIF(:project_meeting_place_id, ''), NULL)::INTEGER,
	:project_meeting_agenda,
	:project_meeting_date::DATE,
	COALESCE(NULLIF(:project_meeting_hour_start, ''), NULL)::TIME,
	COALESCE(NULLIF(:project_meeting_hour_end, ''), NULL)::TIME,
	COALESCE(NULLIF(:project_meeting_duration, ''), NULL)::TIME
);

SET project_meeting_id = (SELECT MAX(project_meeting_id)::INTEGER FROM project_meeting WHERE project_meeting_title=:project_meeting_title AND project_meeting_date=:project_meeting_date::DATE);

INSERT INTO project_meeting_participants
(
project_meeting_id,
user_id,
project_meeting_participant_role,
project_meeting_participant_type
)
VALUES 
(
$project_meeting_id::INTEGER,
$user_id::INTEGER,
'coordinator',
'orga_member'
)

UPDATE project_meeting
SET
project_meeting_participants_nb=project_meeting_participants_nb +1,
updated_at=CURRENT_TIMESTAMP
WHERE project_meeting_id=$project_meeting_id::INTEGER

RETURNING 'redirect' AS component,
 $redirect_link AS link;


