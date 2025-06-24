SET room_id = SELECT room_id FROM project_building_rooms_pictures WHERE room_picture_id = $room_picture_id::INTEGER;
SET building_id = SELECT building_id FROM project_building_rooms WHERE room_id = $room_id::INTEGER;
SET project_id = (SELECT project_id FROM project_building WHERE building_id = $building_id::INTEGER) ;


SET room_picture_url = sqlpage.persist_uploaded_file('room_picture_url', 'x_pictures_spaces', 'doc,docx,odt,md,pdf,jpg,jpeg,png');


SET user_role = (
    SELECT user_role FROM users
    INNER JOIN sessions ON users.user_id = sessions.user_id
    WHERE sessions.session_token = sqlpage.cookie('session_token')
); 

/*
SET redirect_link =
CASE WHEN $user_role = 'supervisor' 
THEN  '/e_project_building_rooms_pictures/room_picture_display_4.sql?room_id='||$room_id
ELSE  '/e_project_building_rooms_pictures/room_picture_display_3.sql?room_id='||$room_id
END;*/

SET redirect_link =
CASE WHEN $user_role = 'supervisor' 
THEN  '/e_project_building_rooms_pictures/building_picture_display_4.sql?building_id='||$building_id
ELSE  '/e_project_building_rooms_pictures/building_picture_display_3.sql?building_id='||$building_id
END;

UPDATE project_building_rooms_pictures 
SET 
room_picture_title=:room_picture_title,
room_picture_status=:room_picture_status,
room_picture_format=:room_picture_format,
room_picture_url =
CASE  
WHEN $room_picture_url IS NULL  THEN room_picture_url
ELSE $room_picture_url
END,
room_picture_summary=:room_picture_summary,
room_id=COALESCE(NULLIF(:room_id, ''), NULL)::INTEGER,
workpackage_id = COALESCE(NULLIF(:workpackage_id, ''), NULL)::INTEGER,
worksequence_id = COALESCE(NULLIF(:worksequence_id, ''), NULL)::INTEGER,
updated_at = CURRENT_TIMESTAMP

WHERE room_picture_id=$room_picture_id::INTEGER

RETURNING  'redirect' AS component,
$redirect_link AS link;