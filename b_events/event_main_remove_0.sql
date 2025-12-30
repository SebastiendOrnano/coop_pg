SET event_id = SELECT event_id FROM event_participants WHERE participant_id  = $participant_id::INTEGER;


SET user_role = (
    SELECT user_role FROM users
    INNER JOIN sessions ON users.user_id = sessions.user_id
    WHERE sessions.session_token = sqlpage.cookie('session_token')
); 

SET redirect_link =
CASE WHEN $user_role = 'supervisor' 
THEN '/b_events/event_poster_4.sql?event_id='||$event_id::INTEGER
ELSE '/b_events/event_poster_3.sql?event_id='||$event_id::INTEGER
END;


DELETE FROM event_participants
WHERE participant_id  = $participant_id::INTEGER;

UPDATE events
SET
event_participants_nb = (SELECT COUNT(participant_id) FROM event_participants WHERE event_id=$event_id::INTEGER),
updated_at = CURRENT_TIMESTAMP
WHERE event_id=$event_id::INTEGER

RETURNING
'redirect' AS component,
$redirect_link AS link;