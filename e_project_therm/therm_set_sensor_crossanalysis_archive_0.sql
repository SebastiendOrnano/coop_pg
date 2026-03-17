SET therm_set_id = SELECT therm_set_id FROM therm_crossanalysis WHERE crossanalysis_id = $crossanalysis_id::INTEGER;
SET room_id = SELECT room_id FROM therm_set WHERE therm_set_id = $therm_set_id::integer;
SET building_id = SELECT building_id FROM project_building_rooms WHERE room_id = $room_id::integer;
SET project_id = SELECT project_id FROM project_building WHERE building_id = $building_id::integer;


UPDATE therm_crossanalysis 
SET crossanalysis_status='archived'
WHERE crossanalysis_id  = $crossanalysis_id::INTEGER

RETURNING
'redirect' AS component,
'/e_project_therm/therm_set_sensor_crossanalysis_display_4.sql?therm_set_id='||$therm_set_id AS link;

