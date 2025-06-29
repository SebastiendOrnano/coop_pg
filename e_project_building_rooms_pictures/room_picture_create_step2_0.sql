SET user_role = (
    SELECT user_role FROM users
    INNER JOIN sessions ON users.user_id = sessions.user_id
    WHERE sessions.session_token = sqlpage.cookie('session_token')
); 

SET redirect_link =
CASE WHEN $user_role = 'supervisor' 
THEN  '/e_project_building_rooms_pictures/room_picture_form_step3_4.sql?room_picture_id='||$room_picture_id
ELSE  '/e_project_building_rooms_pictures/room_picture_form_step3_3.sql?room_picture_id='||$room_picture_id
END;

UPDATE project_building_rooms_pictures 
SET 
room_id=COALESCE(NULLIF(:room_id, ''), NULL)::INTEGER,
worksequence_id=COALESCE(NULLIF(:worksequence_id, ''), NULL)::INTEGER
where room_picture_id=$room_picture_id::INTEGER

RETURNING  'redirect' AS component,
$redirect_link AS link;
