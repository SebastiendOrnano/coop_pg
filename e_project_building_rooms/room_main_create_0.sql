SET building_name = (SELECT building_name FROM project_building WHERE building_id=$building_id::INTEGER);

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

INSERT INTO project_building_rooms
(
	building_id,
	room_name,
	room_status,
	room_summary,
	room_todo,
	room_access,
	room_type,
	room_quality_level,
	room_accessibility,
	room_capacity_seats,
	room_capacity_standup,
	room_width,
	room_length,
	room_height,
	room_wall_material,
	room_floor_material
	)
VALUES 
(
	$building_id::INTEGER,
	:room_name,
	'active',
	:room_summary,
	:room_todo,
	:room_access,
	:room_type,
	:room_quality_level,
	:room_accessibility,
	COALESCE(NULLIF(:room_capacity_seats,''), NULL)::INTEGER, 
	COALESCE(NULLIF(:room_capacity_standup,''), NULL)::INTEGER,
	COALESCE(NULLIF(:room_width,''), NULL)::INTEGER, 
	COALESCE(NULLIF(:room_length,''), NULL)::INTEGER,
	COALESCE(NULLIF(:room_height,''), NULL)::INTEGER,
	:room_wall_material,
	:room_floor_material
)

RETURNING 'redirect' AS component,
$redirect_link  AS link;


