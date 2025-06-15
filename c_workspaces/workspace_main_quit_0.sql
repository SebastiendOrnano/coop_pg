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

SET redirect_link =
CASE WHEN $user_role = 'supervisor' 
THEN '/c_workspaces/workspace_main_display_4.sql'
ELSE '/c_workspaces/workspace_main_display_3.sql'
END;

DELETE FROM workspace_participants
WHERE workspace_id = $workspace_id::INTEGER AND user_id= $user_id::INTEGER;

UPDATE workspaces
SET
workspace_participants_nb = (SELECT COUNT(workspace_participant_id) FROM workspace_participants WHERE workspace_id = $workspace_id::INTEGER),
updated_at=CURRENT_TIMESTAMP
WHERE workspace_id = $workspace_id::INTEGER

RETURNING 
    'redirect' AS component,
    $redirect_link AS link;


