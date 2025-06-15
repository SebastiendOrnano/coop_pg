SET user_role = (
    SELECT user_role FROM users
    INNER JOIN sessions ON users.user_id = sessions.user_id
    WHERE sessions.session_token = sqlpage.cookie('session_token')
); 

SET redirect_link =
    CASE WHEN $user_role = 'supervisor' 
    THEN '/d_prm3_participants/prm3_participant_main_display_4.sql?prm3_id='||$prm3_id
    ELSE '/d_prm3_participants/prm3_participant_main_display_3.sql?prm3_id='||$prm3_id
END;

INSERT INTO prm3_participants
(
employee_id,
prm2_sub_id,
prm3_id,
prm3_participant_role,
prm3_participant_type,
prm3_participant_status
)

VALUES
(
:employee_id::INTEGER,
:prm2_sub_id::INTEGER,
$prm3_id::INTEGER,
:prm3_participant_role,
'employee',
'active'
)

UPDATE prm3
SET 
prm3_nb_participants = prm3_nb_participants +1,
updated_at=CURRENT_TIMESTAMP
WHERE prm3_id=$prm3_id::INTEGER

SELECT 'redirect' as component,
$redirect_link as link;


