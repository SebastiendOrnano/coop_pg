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
THEN '/c_workspaces/workspace_main_display_4.sql'
ELSE '/c_workspaces/workspace_main_display_3.sql'
END;

INSERT INTO workspaces 
(   
	workspace_title,
	workspace_coordinator_id,
	workspace_summary,
	workspace_category,
	workspace_status
)
VALUES 
(   :workspace_title,
	$user_id::INTEGER,
	:workspace_summary,
	:workspace_category,
	:workspace_status
	);

SET workspace_id = (SELECT MAX(workspace_id) FROM workspaces);

INSERT INTO workspace_participants
(
workspace_id,
user_id,
workspace_participant_role
)
VALUES
(
$workspace_id::INTEGER,
$user_id::INTEGER,
'coordinator'
)

RETURNING 'redirect' AS component,
 $redirect_link AS link;


