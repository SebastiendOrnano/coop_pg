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


UPDATE therm_sensor
SET 
    therm_sensor_name=:therm_sensor_name,
	therm_sensor_status=:therm_sensor_status,
	therm_sensor_specifications=:therm_sensor_specifications,
	therm_sensor_manufacturer=:therm_sensor_manufacturer,
	therm_sensor_model=:therm_sensor_model,
	therm_sensor_serie_no=:therm_sensor_serie_no,
	updated_at = CURRENT_TIMESTAMP
WHERE therm_sensor_id = $therm_sensor_id::INTEGER

RETURNING 'redirect' AS component,
$redirect_link  AS link;