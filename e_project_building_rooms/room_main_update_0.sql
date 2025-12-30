SET building_id = (SELECT building_id FROM project_building_rooms WHERE room_id=$room_id::INTEGER);

SET user_role = (
    SELECT user_role FROM users
    INNER JOIN sessions ON users.user_id = sessions.user_id
    WHERE sessions.session_token = sqlpage.cookie('session_token')
); 

SET redirect_link =
CASE WHEN $user_role = 'supervisor' 
THEN  '/e_project_building_rooms/room_main_display_4.sql?building_id='||$building_id
ELSE  '/e_project_building_rooms/room_main_display_3.sql?building_id='||$building_id
END;


UPDATE project_building_rooms 
SET 
room_name=:room_name,
room_rank=:room_rank,
room_status=:room_status,
room_summary=:room_summary,
room_todo=:room_todo,
room_access=:room_access,
room_type = :room_type,
room_quality_level=:room_quality_level,
room_accessibility=:room_accessibility,
room_capacity_seats=COALESCE(NULLIF(:room_capacity_seats, ''), NULL)::INTEGER,
room_capacity_standup=COALESCE(NULLIF(:room_capacity_standup, ''), NULL)::INTEGER,
room_width=COALESCE(NULLIF(:room_width, ''), NULL)::INTEGER,
room_length=COALESCE(NULLIF(:room_length, ''), NULL)::INTEGER,
room_height=COALESCE(NULLIF(:room_height, ''), NULL)::INTEGER,
room_wall_material=:room_wall_material,
room_floor_material=:room_floor_material,
updated_at = CURRENT_TIMESTAMP
WHERE room_id = $room_id::INTEGER

RETURNING 'redirect' AS component,
$redirect_link AS link;


