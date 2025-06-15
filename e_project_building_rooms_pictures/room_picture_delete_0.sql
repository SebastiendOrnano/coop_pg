SET room_id = (SELECT room_id FROM project_building_rooms_pictures WHERE room_picture_id = $room_picture_id::INTEGER) ;
SET building_id = (SELECT building_id FROM project_building_rooms WHERE room_id = $room_id::INTEGER) ;
SET project_id = (SELECT project_id FROM project_building WHERE building_id = $building_id::INTEGER) ;

SET room_picture_url= (SELECT room_picture_url FROM project_building_rooms_pictures WHERE  room_picture_id = $room_picture_id::INTEGER);
INSERT INTO files_to_erase (file_url) VALUES ($room_picture_url);


SET user_role = (
    SELECT user_role FROM users
    INNER JOIN sessions ON users.user_id = sessions.user_id
    WHERE sessions.session_token = sqlpage.cookie('session_token')
); 

SET redirect_link =
CASE WHEN $user_role = 'supervisor' 
THEN '/e_project_building_rooms_pictures/project_picture_display_4.sql?project_id='||$project_id
ELSE '/e_project_building_rooms_pictures/project_picture_display_4.sql?project_id='||$project_id
END;


DELETE FROM project_building_rooms_pictures WHERE room_picture_id  = $room_picture_id::INTEGER;

SELECT 'redirect' AS component,
$redirect_link AS link;