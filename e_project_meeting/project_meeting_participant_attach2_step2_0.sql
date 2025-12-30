SET user_role = (
    SELECT user_role FROM users
    INNER JOIN sessions ON users.user_id = sessions.user_id
    WHERE sessions.session_token = sqlpage.cookie('session_token')
); 

SET redirect_link =
    CASE WHEN $user_role = 'supervisor' 
    THEN  '/e_project_meeting/project_meeting_participants_display_4.sql?project_meeting_id='||$project_meeting_id
    ELSE  '/e_project_meeting/project_meeting_participants_display_3.sql?project_meeting_id='||$project_meeting_id
END;

SET prm1_id = SELECT prm1_id FROM prm2_sub_employees WHERE employee_id = :employee_id::INTEGER;

SET project_meeting_participant_id = SELECT MAX(project_meeting_participant_id) FROM project_meeting_participants WHERE  project_meeting_id = $project_meeting_id::INTEGER;


UPDATE project_meeting_participants
SET
prm1_id=$prm1_id::INTEGER,
employee_id=:employee_id::INTEGER,
project_meeting_participant_status='active',
project_meeting_participant_type='employee',
project_meeting_participant_role = :project_meeting_participant_role
WHERE project_meeting_participant_id = $project_meeting_participant_id::INTEGER

UPDATE project_meeting
SET 
project_meeting_participants_nb = project_meeting_participants_nb +1,
updated_at=CURRENT_TIMESTAMP
WHERE project_meeting_id=$project_meeting_id::INTEGER

SELECT 'redirect' AS component,
$redirect_link AS link;


