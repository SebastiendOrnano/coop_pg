DELETE FROM project_building_rooms WHERE room_id  = $room_id::INTEGER
RETURNING
'redirect' AS component,
'/e_project_building_rooms/room_main_display_4.sql' AS link;