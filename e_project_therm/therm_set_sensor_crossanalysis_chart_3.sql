SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_3.sql') AS properties;

SET therm_set_id = SELECT therm_set_id FROM therm_crossanalysis WHERE crossanalysis_id=$crossanalysis_id::INTEGER;

SET room_id = SELECT  room_id FROM therm_set WHERE therm_set_id=$therm_set_id::INTEGER;
SET building_id = SELECT  building_id FROM project_building_rooms WHERE room_id=$room_id::INTEGER;
SET project_id = SELECT  project_id FROM project_building WHERE building_id=$building_id::INTEGER;

SELECT 
    'breadcrumb' as component;
SELECT 
    'Home' as title,
    '/'    as link;
SELECT 
    'Gestion Editeur'         as title,
    '/a_panels/panel_editor_3.sql' as link;
 SELECT 
    'Projets'            as title,
    '/e_project/project_main_display_3.sql'     as link;   
SELECT 
    'Sensor'            as title,
    '/e_project_therm/therm_sensor_display_3.sql'   as link;  
 SELECT 
    'Hub du projet'            as title,
    '/e_project/project_hub_display_3.sql?project_id='||$project_id     as link;  
SELECT 
    'Campagnes mesure'            as title,
    '/e_project_therm/therm_set_display_3.sql?project_id='||$project_id     as link;
 SELECT 
    'Capteur'            as title,
    '/e_project_therm/therm_set_sensor_display_3.sql?therm_set_id='||$therm_set_id     as link;   


SET datasetsensor1 = (SELECT datasetsensor1 FROM therm_crossanalysis WHERE crossanalysis_id=$crossanalysis_id::INTEGER);
SET datasetsensor2 = (SELECT datasetsensor2 FROM therm_crossanalysis WHERE crossanalysis_id=$crossanalysis_id::INTEGER);

SET date_start_min = (SELECT DATE(crossanalysis_period_start) FROM therm_crossanalysis WHERE crossanalysis_id=$crossanalysis_id::INTEGER LIMIT 1);
SET date_end_max = (SELECT DATE(crossanalysis_period_end) FROM therm_crossanalysis WHERE crossanalysis_id=$crossanalysis_id::INTEGER LIMIT 1);
SET hour_start_min = (SELECT TO_CHAR(crossanalysis_period_start, 'HH24:MI') FROM therm_crossanalysis WHERE crossanalysis_id=$crossanalysis_id::INTEGER  LIMIT 1);
SET hour_end_max = (SELECT TO_CHAR(crossanalysis_period_end, 'HH24:MI') FROM therm_crossanalysis WHERE crossanalysis_id=$crossanalysis_id::INTEGER  LIMIT 1);




SET dataset1_date_start = SELECT Min(therm_data_date + therm_data_hour) FROM therm_data WHERE therm_dataset_id=:datasetsensor1::INTEGER;
SET dataset2_date_start = SELECT Min(therm_data_date + therm_data_hour) FROM therm_data WHERE therm_dataset_id=:datasetsensor2::INTEGER;
SET dataset1_date_end = SELECT Max(therm_data_date + therm_data_hour) FROM therm_data WHERE therm_dataset_id=:datasetsensor1::INTEGER;
SET dataset2_date_end = SELECT Max(therm_data_date + therm_data_hour) FROM therm_data WHERE therm_dataset_id=:datasetsensor2::INTEGER;

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


SET crossanalysis_period_start = SELECT crossanalysis_period_start FROM therm_crossanalysis WHERE crossanalysis_id=$crossanalysis_id::INTEGER;
SET crossanalysis_period_end = SELECT crossanalysis_period_end FROM therm_crossanalysis WHERE crossanalysis_id=$crossanalysis_id::INTEGER;




-- calcul dephasage entre les capteurs
CREATE OR REPLACE VIEW therm_joined AS
SELECT 
    (therm_data_date + therm_data_hour)::timestamp AS ts,
    therm_dataset_id, therm_data_temp, therm_data_rh
FROM therm_data;

SET phase_shift_hours_temp = 
WITH 
temps_precalcule AS 
(
    SELECT ts,
           MAX(CASE WHEN therm_dataset_id = :datasetsensor1::INTEGER THEN therm_data_temp END) AS temp_int,
           MAX(CASE WHEN therm_dataset_id = :datasetsensor2::INTEGER THEN therm_data_temp END) AS temp_ext
    FROM therm_joined
    WHERE therm_dataset_id IN (:datasetsensor1::INTEGER, :datasetsensor2::INTEGER)
    AND ts BETWEEN $crossanalysis_period_start::timestamp AND $crossanalysis_period_end::timestamp
    GROUP BY ts
),
params AS
(
    SELECT 15 * INTERVAL '1 minute' AS dt, 96 AS max_lag
),
lags AS 
(
    SELECT generate_series(-96, 96) AS k, dt FROM params
),
pairs AS 
(
    SELECT l.k, j1.ts, j1.temp_int, j2.temp_ext
    FROM lags l
    JOIN temps_precalcule j1 ON TRUE
    JOIN temps_precalcule j2 ON j2.ts = j1.ts + l.k * l.dt
),
stats AS 
(
    SELECT k, COUNT(*) AS n, AVG(temp_int) AS mean_int, AVG(temp_ext) AS mean_ext
    FROM pairs GROUP BY k
),
covar AS 
(
    SELECT p.k, s.mean_int, s.mean_ext,
           SUM((p.temp_int - s.mean_int) * (p.temp_ext - s.mean_ext)) AS cov,
           STDDEV_POP(p.temp_int) AS sd_int,
           STDDEV_POP(p.temp_ext) AS sd_ext
    FROM pairs p JOIN stats s USING (k)
    GROUP BY p.k, s.mean_int, s.mean_ext
),
corr AS (
    SELECT k, cov / NULLIF(sd_int * sd_ext, 0) AS r 
    FROM covar
),
 best_k_calc AS 
(
    SELECT k FROM corr ORDER BY r DESC LIMIT 1
)
    SELECT k::numeric * 0.25 FROM best_k_calc
;


SET phase_shift_hours_rh = 
WITH 
temps_precalcule AS 
(
    SELECT ts,
           MAX(CASE WHEN therm_dataset_id = :datasetsensor1::INTEGER THEN therm_data_rh END) AS rh_int,
           MAX(CASE WHEN therm_dataset_id = :datasetsensor2::INTEGER THEN therm_data_rh END) AS rh_ext
    FROM therm_joined
    WHERE therm_dataset_id IN (:datasetsensor1::INTEGER, :datasetsensor2::INTEGER)
    AND ts BETWEEN $crossanalysis_period_start::timestamp AND $crossanalysis_period_end::timestamp
    GROUP BY ts
),
params AS
(
    SELECT 15 * INTERVAL '1 minute' AS dt, 96 AS max_lag
),
lags AS 
(
    SELECT generate_series(-96, 96) AS k, dt FROM params
),
pairs AS 
(
    SELECT l.k, j1.ts, j1.rh_int, j2.rh_ext
    FROM lags l
    JOIN temps_precalcule j1 ON TRUE
    JOIN temps_precalcule j2 ON j2.ts = j1.ts + l.k * l.dt
),
stats AS 
(
    SELECT k, COUNT(*) AS n, AVG(rh_int) AS mean_int, AVG(rh_ext) AS mean_ext
    FROM pairs GROUP BY k
),
covar AS 
(
    SELECT p.k, s.mean_int, s.mean_ext,
           SUM((p.rh_int - s.mean_int) * (p.rh_ext - s.mean_ext)) AS cov,
           STDDEV_POP(p.rh_int) AS sd_int,
           STDDEV_POP(p.rh_ext) AS sd_ext
    FROM pairs p JOIN stats s USING (k)
    GROUP BY p.k, s.mean_int, s.mean_ext
),
corr AS (
    SELECT k, cov / NULLIF(sd_int * sd_ext, 0) AS r 
    FROM covar
),
 best_k_calc AS 
(
    SELECT k FROM corr ORDER BY r DESC LIMIT 1
)
    SELECT k::numeric * 0.25 FROM best_k_calc
;


SELECT 
    'form' as component,
    'Rappel des objectifs et du contexte de la campagne de mesure' as title,
    '' as validate;

SELECT
    'therm_set_description' as name,
    'text' as type,  
    'Description' as label,
    true as readonly,
    6 AS width,
    (SELECT therm_set_description FROM therm_set WHERE therm_set_id=$therm_set_id::INTEGER) as value;
SELECT
    'datasetsensor1' as name,
    'Nom du capteur 1' as label,
    'text'      as type,
    3 AS width,
    true as readonly,
    (SELECT therm_sensor_name 
    FROM therm_sensor AS s
    LEFT JOIN (SELECT sensor1_id, sensor2_id,crossanalysis_id FROM therm_crossanalysis) as c 
    ON s.therm_sensor_id = c.sensor1_id
    WHERE c.crossanalysis_id=$crossanalysis_id::INTEGER) as value;
SELECT
    'datasetsensor2' as name,
    'Nom du capteur 2' as label,
    'text'      as type,
    3 AS width,
    true as readonly,
    (SELECT therm_sensor_name 
    FROM therm_sensor AS s
    LEFT JOIN (SELECT sensor1_id, sensor2_id,crossanalysis_id FROM therm_crossanalysis) as c 
    ON s.therm_sensor_id = c.sensor1_id
    WHERE c.crossanalysis_id=$crossanalysis_id::INTEGER) as value;
SELECT
    'crossanalysis_period_start' as name,
    'Début des mesures' as label,
    'text'      as type,
    3 AS width,
    true as readonly,
    (SELECT TO_CHAR($crossanalysis_period_start::timestamp, 'YYYY-MM-DD HH24:MI')) AS value;
SELECT
    'crossanalysis_period_end' as name,
    'Début des mesures' as label,
    'text'      as type,
    3 AS width,
    true as readonly,
    (SELECT TO_CHAR($crossanalysis_period_end::timestamp, 'YYYY-MM-DD HH24:MI')) AS value;

SELECT 
    'datagrid1'              as component,
    'panel_therm_display' as id;
SELECT 
    '/e_project_therm/therm_set_sensor_cross_sample_form_4.sql?crossanalysis_id='||$crossanalysis_id    as link,
    'Sélectionner une plage de données'                  as description,
    'FILTER'                         as title,
    'filter'                                      as icon,
    'yellow'                                         as color;

SELECT 
     '/e_project_therm/therm_set_sensor_crossanalysis_csv_0.sql?crossanalysis_id='||$crossanalysis_id||'&datasetsensor=1'            as link,
    'Télécharger les données csv'        as description,
    'capteur 1'                                    as title,
    'download'                                     as icon,
    'red'                                        as color;
SELECT 
     '/e_project_therm/therm_set_sensor_crossanalysis_csv_0.sql?crossanalysis_id='||$crossanalysis_id||'&datasetsensor=2'             as link,
    'Télécharger les données csv'                  as description,
    'capteur 2'                                    as title,
    'download'                                     as icon,
    'orange'                                        as color;
SELECT 
    'javascript:chartexportsvg_datagrid()'  AS link,
    'chartexporttempsvg'           AS row_id,
    'TEMP'                         as title,
    'Exporter chart en SVG'         as description,
    'download'                     AS icon,
    'green' AS color;
SELECT 
   'javascript:chartexportsvg_datagrid()'  AS link,
   'chartexportrhsvg' AS row_id,   -- pour RH
    'RH'                         as title,
    'Exporter chart en SVG'         as description,
   'download' AS icon,
   'blue' AS color;
SELECT 
     '/e_project_therm/therm_set_sensor_crossanalysis_csv_recap_0.sql?crossanalysis_id='||$crossanalysis_id              as link,
    'Télécharger la récap en csv'                       as description,
    'RECAP'                                             as title,
    'download'                                          as icon,
    'blue'                                              as color;


SELECT 
    'form' as component,
    'recap_dataset_temp'   as id,
    'Comparaison des températures' as title,
    '' as validate;
SELECT
  'facteur_amortissement' AS name,
  'text' AS type,
    '%' as suffix,
  'Facteur amortissement thermique' AS label,
  true AS readonly,
  (
    WITH amps AS (
      SELECT 
        CASE 
        WHEN therm_dataset_id = :datasetsensor2::INTEGER  THEN 'ext'
        WHEN therm_dataset_id = :datasetsensor1::INTEGER THEN 'int' 
        END as type,
        MAX(therm_data_temp) as tmax,
        MIN(therm_data_temp) as tmin
      FROM therm_data
      WHERE therm_dataset_id IN (:datasetsensor2::INTEGER, :datasetsensor1::INTEGER)
    AND (therm_data_date + therm_data_hour)::timestamp BETWEEN $crossanalysis_period_start::timestamp  AND $crossanalysis_period_end::timestamp
      GROUP BY therm_dataset_id
    )
    SELECT 
      (MAX(CASE WHEN type = 'int' THEN tmax END) - MAX(CASE WHEN type = 'int' THEN tmin END)) / 
      NULLIF(MAX(CASE WHEN type = 'ext' THEN tmax END) - MAX(CASE WHEN type = 'ext' THEN tmin END), 0)
    * 100
    FROM amps
  )::numeric(5,1) AS value,
  3 AS width;

SELECT
    'therm_delta_temp' as name,
    'text' as type,  
    'Dephasage' as label,
    true as readonly,
    'heures' as suffix,
    ABS($phase_shift_hours_temp::numeric) AS value,
   3 AS width;
SELECT
    'therm_ecart_type1' AS name,
    'text' AS type,
    'Ecart type dataset 1' AS label,
    true AS readonly,
    (
        SELECT stddev(therm_data_temp)::numeric(10,2)
        FROM therm_data
        WHERE therm_dataset_id = :datasetsensor1::integer
       AND therm_data_date + therm_data_hour BETWEEN $crossanalysis_period_start::timestamp AND $crossanalysis_period_end::timestamp
    ) AS value,
    3 AS width;

SELECT
    'therm_ecart_type2' AS name,
    'text' AS type,
    'Ecart type dataset 2' AS label,
    true AS readonly,
    (
        SELECT stddev(therm_data_temp)::numeric(10,2)
        FROM therm_data
        WHERE therm_dataset_id = :datasetsensor2::integer
        AND therm_data_date + therm_data_hour BETWEEN $crossanalysis_period_start::timestamp AND $crossanalysis_period_end::timestamp
    ) AS value,
    3 AS width;

SELECT 
    'chart'            AS component,
    'Temp'          AS title,
    'chart_temp'         as id,
    'line'             AS type,
    true             AS time,
    true               as date;
SELECT 
    'sensor 1 temp'      AS series,
    therm_data_temp::TEXT     AS y,
    therm_data_date + therm_data_hour AS x
    FROM therm_data  
    WHERE therm_dataset_id=:datasetsensor1::INTEGER
    AND therm_data_date + therm_data_hour BETWEEN $crossanalysis_period_start::timestamp AND $crossanalysis_period_end::timestamp;
SELECT 
    'sensor 2 temp'      AS series,
    therm_data_temp::TEXT     AS y,
    therm_data_date + therm_data_hour AS x
    FROM therm_data  
    WHERE therm_dataset_id=:datasetsensor2::INTEGER
    AND therm_data_date + therm_data_hour BETWEEN $crossanalysis_period_start::timestamp AND $crossanalysis_period_end::timestamp;




SELECT 
    'form' as component,
    'recap_dataset_rh'   as id,
    'Comparaison des taux d''humidité' as title,
    '' as validate;
SELECT
  'facteur_amortissement' AS name,
  'text' AS type,
    '%' as suffix,
  'Facteur amortissement humidité' AS label,
  true AS readonly,
  (
    WITH amps AS (
      SELECT 
        CASE 
        WHEN therm_dataset_id = :datasetsensor2::INTEGER  THEN 'ext'
        WHEN therm_dataset_id = :datasetsensor1::INTEGER THEN 'int' 
        END as type,
        MAX(therm_data_rh) as tmax,
        MIN(therm_data_rh) as tmin
      FROM therm_data
      WHERE therm_dataset_id IN (:datasetsensor2::INTEGER, :datasetsensor1::INTEGER)
     AND therm_data_date + therm_data_hour BETWEEN $crossanalysis_period_start::timestamp AND $crossanalysis_period_end::timestamp
      GROUP BY therm_dataset_id
    )
    SELECT 
      (MAX(CASE WHEN type = 'int' THEN tmax END) - MAX(CASE WHEN type = 'int' THEN tmin END)) / 
      NULLIF(MAX(CASE WHEN type = 'ext' THEN tmax END) - MAX(CASE WHEN type = 'ext' THEN tmin END), 0)
    * 100
    FROM amps
  )::numeric(5,1) AS value,
  3 AS width;

SELECT
    'therm_delta_rh' as name,
    'text' as type,  
    'Dephasa RH' as label,
    true as readonly,
    'heures' as suffix,
    ABS($phase_shift_hours_rh::numeric) AS value,
   3 AS width;


SELECT
    'therm_ecart_type1' AS name,
    'text' AS type,
    'RH Ecart type dataset 1' AS label,
    true AS readonly,
    (
        SELECT stddev(therm_data_rh)::numeric(10,2)
        FROM therm_data
        WHERE therm_dataset_id = :datasetsensor1::integer
         AND therm_data_date + therm_data_hour BETWEEN $crossanalysis_period_start::timestamp AND $crossanalysis_period_end::timestamp
    ) AS value,
    3 AS width;

SELECT
    'therm_ecart_type2' AS name,
    'text' AS type,
    'RH Ecart type dataset 2' AS label,
    true AS readonly,
    (
        SELECT stddev(therm_data_rh)::numeric(10,2)
        FROM therm_data
        WHERE therm_dataset_id = :datasetsensor2::integer
         AND therm_data_date + therm_data_hour BETWEEN $crossanalysis_period_start::timestamp AND $crossanalysis_period_end::timestamp
    ) AS value,
    3 AS width;


SELECT 
    'chart'            AS component,
    'RH'          AS title,
    'chart_rh'         as id,
    'line'             AS type,
    TRUE               AS time,
    true               as date;
SELECT 
    'sensor 1 rh'      AS series,
    therm_data_rh    AS y,
    therm_data_date + therm_data_hour AS x
    FROM therm_data 
    WHERE therm_dataset_id=:datasetsensor1::INTEGER
    AND (therm_data_date::DATE + therm_data_hour::TIME)::timestamp BETWEEN $crossanalysis_period_start::timestamp AND $crossanalysis_period_end::timestamp;
SELECT 
    'sensor 2 rh'      AS series,
    therm_data_rh     AS y,
    therm_data_date + therm_data_hour AS x
    FROM therm_data 
    WHERE therm_dataset_id=:datasetsensor2::INTEGER
    AND (therm_data_date::DATE + therm_data_hour::TIME)::timestamp BETWEEN $crossanalysis_period_start::timestamp AND $crossanalysis_period_end::timestamp;

