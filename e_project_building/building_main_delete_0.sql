set project_id = SELECT project_id FROM project_building WHERE building_id = $building_id::INTEGER;


DELETE FROM project_building_rooms_pictures
WHERE building_id  = $building_id::INTEGER;

DELETE FROM project_building_rooms
WHERE building_id  = $building_id::INTEGER;

DELETE FROM project_building WHERE building_id  = $building_id::INTEGER 
RETURNING
'redirect' AS component,
'/e_project_building/building_main_display_4.sql?project_id='||project_id AS link;