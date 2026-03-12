SET therm_set_sensor_id = SELECT therm_set_sensor_id FROM therm_dataset WHERE therm_dataset_id = $therm_dataset_id::integer
SET therm_set_id = SELECT therm_set_id FROM therm_set_sensor WHERE therm_set_sensor_id=$therm_set_sensor_id::INTEGER;
SET room_id = (SELECT room_id FROM therm_set WHERE therm_set_id = $therm_set_id::integer);
SET building_id = (SELECT building_id  FROM project_building_rooms  WHERE room_id = $room_id::integer);
SET project_id = (SELECT project_id  FROM project_building  WHERE building_id = $building_id::integer);


DROP TABLE IF EXISTS therm_dataset_tmp;

CREATE TEMP TABLE therm_dataset_tmp (
  therm_data_temp  numeric(4,1),
  therm_data_rh    numeric(3,1),
  therm_data_co2   numeric(10,2),
  therm_data_date  date,
  therm_data_hour  time
);

COPY therm_dataset_tmp (
  therm_data_temp,
  therm_data_rh,
  therm_data_co2,
  therm_data_date,
  therm_data_hour
)
FROM 'dataset_sensor_input'
WITH (
  FORMAT csv,
  HEADER true,
  DELIMITER ';',
  QUOTE '"',
  NULL '',
  FORCE_NULL (therm_data_temp,therm_data_rh, therm_data_co2)
);

INSERT INTO therm_data (
  therm_dataset_id,
  therm_data_temp,
  therm_data_rh,
  therm_data_co2,
  therm_data_status,
  therm_data_selected,
  therm_data_hour,
  therm_data_date
)
SELECT
  $therm_dataset_id::INTEGER  AS therm_dataset_id,
  therm_data_temp,
  therm_data_rh,
  therm_data_co2,
  'active' AS therm_data_status,
  'false'      AS therm_data_selected,
  therm_data_hour,
  therm_data_date
FROM therm_dataset_tmp;

SET user_role = (
    SELECT user_role FROM users
    INNER JOIN sessions ON users.user_id = sessions.user_id
    WHERE sessions.session_token = sqlpage.cookie('session_token')
); 

SET rights =
CASE WHEN $user_role = 'supervisor' 
THEN  '_4.sql'
ELSE  '_3.sql'
END;

SELECT 
  'alert'   AS component,
  'Success' AS title,
  'L''import semble s''etre bien passé. [revenir à la liste des jeux de données](/e_project_therm/therm_dataset_display'||$rights||'?therm_set_sensor_id='||$therm_set_sensor_id||')' AS description_md,
  'check'   AS icon,
  'green'   AS color;
