SET user_role = (
    SELECT user_role FROM users
    INNER JOIN sessions ON users.user_id = sessions.user_id
    WHERE sessions.session_token = sqlpage.cookie('session_token')
); 

SET redirect_link =
CASE WHEN $user_role = 'supervisor' 
THEN  '/e_project/project_main_display_4.sql'
ELSE  '/e_project/project_main_display_3.sql'
END;


UPDATE project
SET
project_status = :project_status,
project_name=:project_name,
project_summary=:project_summary,
project_date_creation=COALESCE(NULLIF(:project_date_creation,''), NULL)::DATE,
project_date_start_scheduled=COALESCE(NULLIF(:project_date_start_scheduled,''), NULL)::DATE,
project_date_start_actual=COALESCE(NULLIF(:project_date_start_actual,''), NULL)::DATE,
project_duration_scheduled=COALESCE(NULLIF(:project_duration_scheduled, ''), NULL)::INTEGER,
project_duration_actual = COALESCE(NULLIF(:project_duration_actual, ''), NULL)::INTEGER,
project_category=:project_category,
updated_at = CURRENT_TIMESTAMP
WHERE project_id=$project_id::INTEGER

RETURNING 'redirect' AS component,
$redirect_link AS link;