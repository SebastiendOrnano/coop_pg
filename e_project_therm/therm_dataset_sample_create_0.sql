SET user_role = (
    SELECT user_role FROM users
    INNER JOIN sessions ON users.user_id = sessions.user_id
    WHERE sessions.session_token = sqlpage.cookie('session_token')
); 


INSERT INTO therm_dataset_sample
(
therm_dataset_id,
therm_dataset_sample_date_start,
therm_dataset_sample_date_end,
therm_dataset_sample_hour_start,
therm_dataset_sample_hour_end,
created_at
)
VALUES
(
  $therm_dataset_id::INTEGER,
  COALESCE(NULLIF(:therm_dataset_sample_date_start, '')::date,
           NULLIF(:date_start_min, '')::date),
  COALESCE(NULLIF(:therm_dataset_sample_date_end, '')::date,
           NULLIF(:date_end_max, '')::date),
  COALESCE(NULLIF(:therm_dataset_sample_hour_start, '')::time,
           NULLIF(:hour_start_min, '')::time),
  COALESCE(NULLIF(:therm_dataset_sample_hour_end, '')::time,
           NULLIF(:hour_end_max, '')::time),
  CURRENT_TIMESTAMP
);

SET therm_dataset_sample_id = (SELECT MAX(therm_dataset_sample_id) FROM therm_dataset_sample WHERE therm_dataset_id = $therm_dataset_id::INTEGER);

SET redirect_link =
CASE WHEN $user_role = 'supervisor' 
THEN  '/e_project_therm/therm_dataset_sample_chart_4.sql?therm_dataset_sample_id='||$therm_dataset_sample_id
ELSE  '/e_project_therm/therm_dataset_sample_chart_3.sql?therm_dataset_sample_id='||$therm_dataset_sample_id
END;


WITH params AS (
  SELECT
    (therm_dataset_sample_date_start + therm_dataset_sample_hour_start) AS therm_dataset_sample_period_start,
    (therm_dataset_sample_date_end   + therm_dataset_sample_hour_end)   AS therm_dataset_sample_period_end,
    therm_dataset_id
  FROM therm_dataset_sample WHERE therm_dataset_sample_id=$therm_dataset_sample_id::INTEGER
)
SELECT
  'redirect' AS component,
  CASE
    WHEN therm_dataset_sample_period_end < therm_dataset_sample_period_start THEN
      '/e_project_therm/therm_dataset_sample_alert1_0.sql?therm_dataset_id='||$therm_dataset_id
    ELSE
      $redirect_link
  END AS link
FROM params;

