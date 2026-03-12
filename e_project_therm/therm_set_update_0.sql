SET room_id = SELECT room_id FROM therm_set WHERE therm_set_id = $therm_set_id::integer;
SET building_id = SELECT building_id FROM project_building_rooms WHERE room_id = $room_id::integer;
SET project_id = SELECT project_id FROM project_building WHERE building_id = $building_id::integer;


SET user_role = (
    SELECT user_role FROM users
    INNER JOIN sessions ON users.user_id = sessions.user_id
    WHERE sessions.session_token = sqlpage.cookie('session_token')
); 

SET redirect_link =
CASE WHEN $user_role = 'supervisor' 
THEN  '/e_project_therm/therm_set_display_4.sql?project_id='||$project_id
ELSE  '/e_project_therm/therm_set_display_3.sql?project_id='||$project_id
END;

UPDATE therm_set 
SET 
therm_set_name=:therm_set_name,
therm_set_status=:therm_set_status,
therm_set_description=:therm_set_description,
updated_at = CURRENT_TIMESTAMP
WHERE therm_set_id = $therm_set_id::INTEGER

RETURNING 'redirect' AS component,
$redirect_link AS link;


