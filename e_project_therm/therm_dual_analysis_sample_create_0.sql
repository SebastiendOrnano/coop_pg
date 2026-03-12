SET user_role = (
    SELECT user_role FROM users
    INNER JOIN sessions ON users.user_id = sessions.user_id
    WHERE sessions.session_token = sqlpage.cookie('session_token')
); 

SET redirect_link1 =
CASE WHEN $user_role = 'supervisor' 
THEN '/e_project_therm/therm_dual_analysis_sample_chart_step1_4.sql?dual_analysis_sample_id='||$dual_analysis_sample_id
ELSE '/e_project_therm/therm_dual_analysis_sample_chart_step1_3.sql?dual_analysis_sample_id='||$dual_analysis_sample_id
END;


INSERT INTO therm_dual_analysis_sample
(
  dual_analysis_id,
  dataset1_sample_date_start,
  dataset1_sample_hour_start,
  dataset1_sample_date_end,
  dataset1_sample_hour_end,
  dataset2_sample_date_start,
  dataset2_sample_hour_start,
  dataset2_sample_date_end,
  dataset2_sample_hour_end,
  created_at
)
VALUES
(
  $dual_analysis_id::INTEGER,

  COALESCE(NULLIF(:sample_day_start1, '')::date,
           NULLIF(:date_start_min1, '')::date),

  COALESCE(NULLIF(:sample_hour_start1, '')::time,
           NULLIF(:hour_start_min1, '')::time),

  COALESCE(NULLIF(:sample_day_end1, '')::date,
           NULLIF(:date_end_max1, '')::date),

  COALESCE(NULLIF(:sample_hour_end1, '')::time,
           NULLIF(:hour_end_max1, '')::time),

  COALESCE(NULLIF(:sample_day_start2, '')::date,
           NULLIF(:date_start_min2, '')::date),

  COALESCE(NULLIF(:sample_hour_start2, '')::time,
           NULLIF(:hour_start_min2, '')::time),

  COALESCE(NULLIF(:sample_day_end2, '')::date,
           NULLIF(:date_end_max2, '')::date),

  COALESCE(NULLIF(:sample_hour_end2, '')::time,
           NULLIF(:hour_end_max2, '')::time),

  CURRENT_TIMESTAMP
);


SET dual_analysis_sample_id = (SELECT MAX(dual_analysis_sample_id) FROM therm_dual_analysis_sample WHERE dual_analysis_id = $dual_analysis_id::INTEGER);

SET period_start1 = (
  SELECT
    (dataset1_sample_date_start::date 
     + dataset1_sample_hour_start::time)::timestamp
    FROM  therm_dual_analysis_sample
    WHERE dual_analysis_sample_id = $dual_analysis_sample_id::INTEGER
);
SET period_end1 = (
  SELECT
    (dataset1_sample_date_end::date 
     + dataset1_sample_hour_end::time)::timestamp
    FROM  therm_dual_analysis_sample
    WHERE dual_analysis_sample_id = $dual_analysis_sample_id::INTEGER
);
SET period_start2 = (
  SELECT
    (dataset2_sample_date_start::date 
     + dataset2_sample_hour_start::time)::timestamp
    FROM  therm_dual_analysis_sample
     WHERE dual_analysis_sample_id = $dual_analysis_sample_id::INTEGER
);
SET period_end2 = (
  SELECT
    (dataset2_sample_date_end::date 
     + dataset2_sample_hour_end::time)::timestamp
    FROM  therm_dual_analysis_sample
     WHERE dual_analysis_sample_id = $dual_analysis_sample_id::INTEGER
);


SET redirect_link = 
(
SELECT 
CASE
  WHEN $period_end1 < $period_start1 
  THEN '/e_project_therm/therm_dual_analysis_sample_alert1_0.sql?dual_analysis_id='||$dual_analysis_id::INTEGER

  WHEN $period_end2 < $period_start2 
 THEN '/e_project_therm/therm_dual_analysis_sample_alert1_0.sql?dual_analysis_id='||$dual_analysis_id::INTEGER

  WHEN (NULLIF(:sample_day_start1, '')::date + NULLIF(:sample_hour_start1, '')::time)::timestamp
       > ($date_start_min1::date + $hour_start_min1::time)::timestamp 
  THEN '/e_project_therm/therm_dual_analysis_sample_alert1_0.sql?dual_analysis_id='||$dual_analysis_id::INTEGER

  WHEN (NULLIF(:sample_day_start2, '')::date + NULLIF(:sample_hour_start2, '')::time)::timestamp
       > ($date_start_min2::date + $hour_start_min2::time)::timestamp 
 THEN '/e_project_therm/therm_dual_analysis_sample_alert1_0.sql?dual_analysis_id='||$dual_analysis_id::INTEGER

  WHEN (NULLIF(:sample_day_end1, '')::date + NULLIF(:sample_hour_end1, '')::time)::timestamp
       > ($date_end_max1::date + $hour_end_max1::time)::timestamp 
 THEN '/e_project_therm/therm_dual_analysis_sample_alert1_0.sql?dual_analysis_id='||$dual_analysis_id::INTEGER

  WHEN (NULLIF(:sample_day_end2, '')::date + NULLIF(:sample_hour_end2, '')::time)::timestamp
       > ($date_end_max2::date + $hour_end_max2::time)::timestamp 
  THEN '/e_project_therm/therm_dual_analysis_sample_alert1_0.sql?dual_analysis_id='||$dual_analysis_id::INTEGER

WHEN (
        SELECT (dataset1_sample_date_start::date + dataset1_sample_hour_start::time)::timestamp
        FROM therm_dual_analysis_sample
        WHERE dual_analysis_sample_id = $dual_analysis_sample_id::INTEGER
      ) 
    < 
      (
        SELECT (MIN(therm_data_date::date + therm_data_hour::time))::timestamp
        FROM therm_data
        WHERE therm_dataset_id = :dataset1::INTEGER
      )
THEN '/e_project_therm/therm_dual_analysis_sample_alert1_0.sql?dual_analysis_id='||$dual_analysis_id::INTEGER
WHEN (
        SELECT (dataset1_sample_date_end::date + dataset1_sample_hour_end::time)::timestamp
        FROM therm_dual_analysis_sample
        WHERE dual_analysis_sample_id = $dual_analysis_sample_id::INTEGER
      ) 
    >
      (
        SELECT (MAX(therm_data_date::date + therm_data_hour::time))::timestamp
        FROM therm_data
        WHERE therm_dataset_id = :dataset1::INTEGER
      )
THEN '/e_project_therm/therm_dual_analysis_sample_alert1_0.sql?dual_analysis_id='||$dual_analysis_id::INTEGER
WHEN (
        SELECT (dataset2_sample_date_start::date + dataset2_sample_hour_start::time)::timestamp
        FROM therm_dual_analysis_sample
        WHERE dual_analysis_sample_id = $dual_analysis_sample_id::INTEGER
      ) 
    < 
      (
        SELECT (MIN(therm_data_date::date + therm_data_hour::time))::timestamp
        FROM therm_data
        WHERE therm_dataset_id = :dataset2::INTEGER
      )
THEN '/e_project_therm/therm_dual_analysis_sample_alert1_0.sql?dual_analysis_id='||$dual_analysis_id::INTEGER
WHEN (
        SELECT (dataset2_sample_date_end::date + dataset2_sample_hour_end::time)::timestamp
        FROM therm_dual_analysis_sample
        WHERE dual_analysis_sample_id = $dual_analysis_sample_id::INTEGER
      ) 
    >
      (
        SELECT (MAX(therm_data_date::date + therm_data_hour::time))::timestamp
        FROM therm_data
        WHERE therm_dataset_id = :dataset2::INTEGER
      )
THEN '/e_project_therm/therm_dual_analysis_sample_alert1_0.sql?dual_analysis_id='||$dual_analysis_id::INTEGER

ELSE $redirect_link1
END);


SELECT
  'redirect' AS component,
  $redirect_link AS link;


