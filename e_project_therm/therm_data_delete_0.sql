SET therm_dataset_id= SELECT therm_dataset_id FROM therm_data WHERE therm_data_id =$therm_data_id::INTEGER;
SET therm_set_sensor_id = SELECT therm_set_sensor_id FROM therm_dataset WHERE therm_dataset_id = $therm_dataset_id::integer
SET therm_set_id = SELECT therm_set_id FROM therm_set_sensor WHERE therm_set_sensor_id=$therm_set_sensor_id::INTEGER;
SET room_id = (SELECT room_id FROM therm_set WHERE therm_set_id = $therm_set_id::integer);
SET building_id = (SELECT building_id  FROM project_building_rooms  WHERE room_id = $room_id::integer);
SET project_id = (SELECT project_id  FROM project_building  WHERE building_id = $building_id::integer);

SET user_role = (
    SELECT user_role FROM users
    INNER JOIN sessions ON users.user_id = sessions.user_id
    WHERE sessions.session_token = sqlpage.cookie('session_token')
); 

SET redirect_link =
CASE WHEN $user_role = 'supervisor' 
THEN  '/e_project_therm/therm_data_display_4.sql?therm_dataset_id='||$therm_dataset_id
ELSE  '/e_project_therm/therm_data_display_3.sql?therm_dataset_id='||$therm_dataset_id
END;

DELETE FROM therm_data WHERE therm_data_id  = $therm_data_id::INTEGER
RETURNING
'redirect' AS component,
$redirect_link AS link;


