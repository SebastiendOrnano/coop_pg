SET therm_set_sensor_id = SELECT therm_set_sensor_id FROM therm_dataset WHERE therm_dataset_id = $therm_dataset_id::integer
SET therm_set_id = SELECT therm_set_id FROM therm_set_sensor WHERE therm_set_sensor_id=$therm_set_sensor_id::INTEGER;
SET room_id = (SELECT room_id FROM therm_set WHERE therm_set_id = $therm_set_id::integer);
SET building_id = (SELECT building_id  FROM project_building_rooms  WHERE room_id = $room_id::integer);
SET project_id = (SELECT project_id  FROM project_building  WHERE building_id = $building_id::integer);


DELETE  FROM therm_data WHERE therm_dataset_id  = $therm_dataset_id::INTEGER


SELECT 
  'alert'   AS component,
  'Success' AS title,
  'La purge semble s''être bien passée. [revenir à la liste des jeux de données](/e_project_therm/therm_dataset_display_4.sql?therm_set_sensor_id='||$therm_set_sensor_id||')'  AS description_md,
  'check'   AS icon,
  'green'   AS color;



