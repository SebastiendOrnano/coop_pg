SET user_role = (
    SELECT user_role FROM users
    INNER JOIN sessions ON users.user_id = sessions.user_id
    WHERE sessions.session_token = sqlpage.cookie('session_token')
); 



INSERT INTO therm_crossanalysis_sample
(
crossanalysis_id,
crossanalysis_sample_date_start,
crossanalysis_sample_date_end,
crossanalysis_sample_hour_start,
crossanalysis_sample_hour_end,
created_at
)
VALUES
(
  $crossanalysis_id::INTEGER,
  COALESCE(NULLIF(:crossanalysis_sample_date_start, '')::date,
           NULLIF(:date_start_min, '')::date),
  COALESCE(NULLIF(:crossanalysis_sample_date_end, '')::date,
           NULLIF(:date_end_max, '')::date),
  COALESCE(NULLIF(:crossanalysis_sample_hour_start, '')::time,
           NULLIF(:hour_start_min, '')::time),
  COALESCE(NULLIF(:crossanalysis_sample_hour_end, '')::time,
           NULLIF(:hour_end_max, '')::time),
  CURRENT_TIMESTAMP
);



SET crossanalysis_sample_id = (SELECT MAX(crossanalysis_sample_id) FROM therm_crossanalysis_sample WHERE crossanalysis_id = $crossanalysis_id::INTEGER);

SET redirect_link1 =
CASE WHEN $user_role = 'supervisor' 
THEN '/e_project_therm/therm_set_sensor_cross_sample_chart_4.sql?crossanalysis_sample_id='||$crossanalysis_sample_id
ELSE '/e_project_therm/therm_set_sensor_cross_sample_chart_3.sql?crossanalysis_sample_id='||$crossanalysis_sample_id
END;




SET redirect_link = 
(
SELECT 
  CASE
 WHEN $period_end < $period_start
 THEN '/e_project_therm/therm_set_sensor_cross_sample_alert1_0.sql?crossanalysis_id='||$crossanalysis_id
  WHEN :crossanalysis_period_start > $period_start
  THEN '/e_project_therm/therm_set_sensor_cross_sample_alert1_0.sql?crossanalysis_id='||$crossanalysis_id
  WHEN :crossanalysis_period_end < $period_end
  THEN '/e_project_therm/therm_set_sensor_cross_sample_alert1_0.sql?crossanalysis_id='||$crossanalysis_id
  ELSE $redirect_link1
  END
);

SELECT
  'redirect' AS component,
  $redirect_link AS link;


