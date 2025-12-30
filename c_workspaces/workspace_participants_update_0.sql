SET user_role = (
    SELECT user_role FROM users
    INNER JOIN sessions ON users.user_id = sessions.user_id
    WHERE sessions.session_token = sqlpage.cookie('session_token')
); 

SET redirect_link =
CASE WHEN $user_role = 'supervisor' 
THEN '/c_workspaces/workspace_participants_display_3.sql?workspace_id='||$workspace_id 
ELSE '/c_workspaces/workspace_participants_display_3.sql?workspace_id='||$workspace_id
END;


UPDATE workspace_participants
SET 
workspace_participant_role='coordinator',
updated_at = CURRENT_TIMESTAMP
WHERE workspace_participant_id = $workspace_participant_id AND workspace_id=$workspace_id

SELECT 'redirect' AS component,
$redirect_link AS link;


