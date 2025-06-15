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
THEN '/c_workspaces/workmeeting_participants_display_4.sql?workmeeting_id='||$workmeeting_id
ELSE '/c_workspaces/workmeeting_participants_display_3.sql?workmeeting_id='||$workmeeting_id
END;

DELETE FROM workmeeting_participants
WHERE user_id=$user_id::INTEGER and workmeeting_id=$workmeeting_id::INTEGER;

UPDATE workmeetings
SET
workmeeting_participants_nb = workmeeting_participants_nb -1,
updated_at=CURRENT_TIMESTAMP
WHERE workmeeting_id = $workmeeting_id::INTEGER

RETURNING 
    'redirect' AS component,
    $redirect_link AS link;


