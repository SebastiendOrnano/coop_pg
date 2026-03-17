SET user_role = (
    SELECT user_role FROM users
    INNER JOIN sessions ON users.user_id = sessions.user_id
    WHERE sessions.session_token = sqlpage.cookie('session_token')
); 

SET dataset1_date_start = SELECT Min(therm_data_date + therm_data_hour) FROM therm_data WHERE therm_dataset_id=:dataset_sensor1::INTEGER;
SET dataset2_date_start = SELECT Min(therm_data_date + therm_data_hour) FROM therm_data WHERE therm_dataset_id=:dataset_sensor2::INTEGER;
SET dataset1_date_end = SELECT Max(therm_data_date + therm_data_hour) FROM therm_data WHERE therm_dataset_id=:dataset_sensor1::INTEGER;
SET dataset2_date_end = SELECT Max(therm_data_date + therm_data_hour) FROM therm_data WHERE therm_dataset_id=:dataset_sensor2::INTEGER;

SET crossanalysis_period_start =
CASE WHEN $dataset1_date_start >= $dataset2_date_start
THEN $dataset1_date_start
ELSE $dataset2_date_start
END;

SET crossanalysis_period_end =
CASE WHEN $dataset1_date_end >= $dataset2_date_end
THEN $dataset2_date_end
ELSE $dataset1_date_end
END;

UPDATE  therm_crossanalysis 
SET 
    dataset_sensor1=:dataset_sensor1::INTEGER,
    dataset_sensor2=:dataset_sensor2::INTEGER,
    dataset1_date_start= $dataset1_date_start::timestamp,
    dataset1_date_end= $dataset1_date_end::timestamp,
    dataset2_date_start= $dataset2_date_start::timestamp,
    dataset2_date_end = $dataset2_date_end::timestamp,
    crossanalysis_period_start=$crossanalysis_period_start::timestamp,
    crossanalysis_period_end= $crossanalysis_period_end::timestamp
WHERE crossanalysis_id =$crossanalysis_id::INTEGER;

SET crossanalysis_period_start = SELECT crossanalysis_period_start FROM therm_crossanalysis WHERE crossanalysis_id=$crossanalysis_id::INTEGER;
SET crossanalysis_period_end = SELECT crossanalysis_period_end FROM therm_crossanalysis WHERE crossanalysis_id=$crossanalysis_id::INTEGER;

SET redirect_link1 =
CASE WHEN $user_role = 'supervisor' 
THEN '/e_project_therm/therm_set_sensor_crossanalysis_chart_4.sql?crossanalysis_id='||$crossanalysis_id
ELSE '/e_project_therm/therm_set_sensor_crossanalysis_chart_3.sql?crossanalysis_id='||$crossanalysis_id
END;

SET redirect_link = 
(
SELECT 
  CASE
 WHEN $crossanalysis_period_end < $crossanalysis_period_start
 THEN '/e_project_therm/therm_set_sensor_crossanalysis_alert1_0.sql?crossanalysis_id='||$crossanalysis_id
  ELSE $redirect_link1
  END
);

SELECT
  'redirect' AS component,
  $redirect_link AS link;