SET user_role = (
    SELECT user_role FROM users
    INNER JOIN sessions ON users.user_id = sessions.user_id
    WHERE sessions.session_token = sqlpage.cookie('session_token')
); 

SET redirect_link =
CASE WHEN $user_role = 'supervisor' 
THEN  '/e_project_therm/therm_sensor_display_4.sql'
ELSE  '/e_project_therm/therm_sensor_display_3.sql'
END;

DELETE FROM therm_sensor WHERE therm_sensor_id  = $therm_sensor_id::INTEGER;

SELECT 'redirect' as component,
$redirect_link as link;