SET user_role = (
    SELECT user_role FROM users
    INNER JOIN sessions ON users.user_id = sessions.user_id
    WHERE sessions.session_token = sqlpage.cookie('session_token')
); 

SET redirect_link =
CASE WHEN $user_role = 'supervisor' 
THEN  '/e_project_therm/therm_dataset_display_4.sql?therm_set_sensor_id='||$therm_set_sensor_id
ELSE  '/e_project_therm/therm_dataset_display_3.sql?therm_set_sensor_id='||$therm_set_sensor_id
END;

INSERT INTO therm_dataset
(
	therm_dataset_name,
	therm_set_sensor_id,
	therm_dataset_status
	)
VALUES 
(
	:therm_dataset_name,
	$therm_set_sensor_id::INTEGER,
	'active'
)

RETURNING 'redirect' AS component,
$redirect_link  AS link;