set workpackage_id = SELECT workpackage_id FROM project_workpackage_waste WHERE waste_id=$waste_id::INTEGER;

SET user_role = (
    SELECT user_role FROM users
    INNER JOIN sessions ON users.user_id = sessions.user_id
    WHERE sessions.session_token = sqlpage.cookie('session_token')
); 

SET redirect_link =
CASE WHEN $user_role = 'supervisor' 
THEN  '/e_project_workpackage_waste/waste_main_display_4.sql?workpackage_id='||$workpackage_id
ELSE  '/e_project_workpackage_waste/waste_main_display_3.sql?workpackage_id='||$workpackage_id
END;

DELETE FROM project_workpackage_waste WHERE waste_id  = $waste_id::INTEGER;

SELECT 'redirect' AS component,
$redirect_link AS link;