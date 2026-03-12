SELECT 
  'redirect' AS component,
  '/e_project_therm/therm_sensor_create_alert1.sql' AS link
WHERE  EXISTS (
  SELECT 1 FROM therm_sensor WHERE therm_sensor_name = :therm_sensor_name
);

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


INSERT INTO therm_sensor
(
	therm_sensor_name,
	therm_sensor_status,
	therm_sensor_specifications,
	therm_sensor_manufacturer,
	therm_sensor_model,
	therm_sensor_serie_no
	)
VALUES 
(
	:therm_sensor_name,
	'active',
	:therm_sensor_specifications,
	:therm_sensor_manufacturer,
	:therm_sensor_model,
	:therm_sensor_serie_no
)

RETURNING 'redirect' AS component,
$redirect_link  AS link;