SET workpackage_id = SELECT workpackage_id FROM project_workpackage_participants WHERE workpackage_participant_id=$workpackage_participant_id::INTEGER;


SET user_role = (
    SELECT user_role FROM users
    INNER JOIN sessions ON users.user_id = sessions.user_id
    WHERE sessions.session_token = sqlpage.cookie('session_token')
); 

SET redirect_link =
CASE WHEN $user_role = 'supervisor' 
THEN     '/e_project_workpackage_participants/workpackage_participant_main_display_4.sql?workpackage_id='||$workpackage_id
ELSE     '/e_project_workpackage_participants/workpackage_participant_main_display_3.sql?workpackage_id='||$workpackage_id
END;


UPDATE project_workpackage_participants 
SET
workpackage_participant_status='archived',
updated_at=CURRENT_TIMESTAMP
WHERE workpackage_participant_id=$workpackage_participant_id::INTEGER;

SELECT 
    'redirect'      AS component,
    $redirect_link  AS link;