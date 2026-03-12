SET therm_set_id = SELECT therm_set_id FROM therm_crossanalysis WHERE crossanalysis_id=$crossanalysis_id::INTEGER;
SET room_id = (SELECT room_id FROM therm_set WHERE therm_set_id = $therm_set_id::integer);
SET building_id = (SELECT building_id  FROM project_building_rooms  WHERE room_id = $room_id::integer);
SET project_id = (SELECT project_id  FROM project_building  WHERE building_id = $building_id::integer);

SET datasetsensor1 = SELECT datasetsensor1 FROM therm_crossanalysis WHERE crossanalysis_id=$crossanalysis_id::INTEGER;
SET datasetsensor2 = SELECT datasetsensor2 FROM therm_crossanalysis WHERE crossanalysis_id=$crossanalysis_id::INTEGER;
SET crossanalysis_period_start = SELECT crossanalysis_period_start FROM therm_crossanalysis WHERE crossanalysis_id=$crossanalysis_id::INTEGER;
SET crossanalysis_period_end = SELECT crossanalysis_period_end FROM therm_crossanalysis WHERE crossanalysis_id=$crossanalysis_id::INTEGER;


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
           MAX(CASE WHEN therm_dataset_id = $datasetsensor1::INTEGER THEN therm_data_temp END) AS temp_int,
           MAX(CASE WHEN therm_dataset_id = $datasetsensor2::INTEGER THEN therm_data_temp END) AS temp_ext
    FROM therm_joined
    WHERE therm_dataset_id IN ($datasetsensor1::INTEGER, $datasetsensor2::INTEGER)
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
    'csv' AS component,
    'Récap Mesures' AS title,
    'recap_mesures.csv' AS filename,
    'file-download' AS icon,
    'blue' AS color,
    '"' AS quote,    
    ';' AS separator,
    TRUE AS bom;

SELECT 
'"Contexte mesures"' as therm_set_description,
'"Debut mesures"' as crossanalysis_period_start,
'"Fin mesures"' as crossanalysis_period_end,
'"Nom capteur 1"' as datasetsensor1,
'"Nom capteur 2"' as datasetsensor2,
'"Facteur amortissement Temp"' as facteur_amortissement,
'"Dephasage Temp"' as therm_delta_temp,
'"Ecart-type Temp capteur 1"' as therm_ecart_type1,
'"Ecart-type Temp capteur 2"' as therm_ecart_type2,
'"Facteur amortissement RH"' as facteur_amortissement_rh,
'"Dephasage RH"' as therm_delta_rh,
'"Ecart-type RH capteur 1"' as therm_ecart_type1_rh,
'"Ecart-type RH capteur 2"' as therm_ecart_type2_rh;

SELECT
    (SELECT therm_set_description FROM therm_set WHERE therm_set_id=$therm_set_id::INTEGER)  as therm_set_description,
    
    $crossanalysis_period_start::timestamp as crossanalysis_period_start,
    $crossanalysis_period_end::timestamp as crossanalysis_period_end,
    
    
    
    (SELECT therm_sensor_name 
    FROM therm_sensor AS s
    LEFT JOIN (SELECT sensor1_id, sensor2_id,crossanalysis_id FROM therm_crossanalysis) as c 
    ON s.therm_sensor_id = c.sensor1_id
    WHERE c.crossanalysis_id=$crossanalysis_id::INTEGER) as datasetsensor1,

    (SELECT therm_sensor_name 
    FROM therm_sensor AS s
    LEFT JOIN (SELECT sensor1_id, sensor2_id,crossanalysis_id FROM therm_crossanalysis) as c 
    ON s.therm_sensor_id = c.sensor2_id
    WHERE c.crossanalysis_id=$crossanalysis_id::INTEGER) as datasetsensor2,
(
    WITH amps AS (
      SELECT 
        CASE 
        WHEN therm_dataset_id = $datasetsensor2::INTEGER  THEN 'ext'
        WHEN therm_dataset_id = $datasetsensor1::INTEGER THEN 'int' 
        END as type,
        MAX(therm_data_temp) as tmax,
        MIN(therm_data_temp) as tmin
      FROM therm_data
      WHERE therm_dataset_id IN ($datasetsensor2::INTEGER, $datasetsensor1::INTEGER)
    AND (therm_data_date + therm_data_hour)::timestamp BETWEEN $crossanalysis_period_start::timestamp  AND $crossanalysis_period_end::timestamp
      GROUP BY therm_dataset_id
    )
    SELECT 
      (MAX(CASE WHEN type = 'int' THEN tmax END) - MAX(CASE WHEN type = 'int' THEN tmin END)) / 
      NULLIF(MAX(CASE WHEN type = 'ext' THEN tmax END) - MAX(CASE WHEN type = 'ext' THEN tmin END), 0)
    * 100
    FROM amps
  )::numeric(5,1) as facteur_amortissement,

ABS($phase_shift_hours_temp::numeric) as therm_delta_temp,

    (
    SELECT stddev(therm_data_temp)::numeric(10,2)
    FROM therm_data
    WHERE therm_dataset_id = :datasetsensor1::integer
    AND therm_data_date + therm_data_hour BETWEEN $crossanalysis_period_start::timestamp AND $crossanalysis_period_end::timestamp
    ) as therm_ecart_type1,

 (
        SELECT stddev(therm_data_temp)::numeric(10,2)
        FROM therm_data
        WHERE therm_dataset_id = :datasetsensor2::integer
        AND therm_data_date + therm_data_hour BETWEEN $crossanalysis_period_start::timestamp AND $crossanalysis_period_end::timestamp
    ) as therm_ecart_type2,

(
    WITH amps AS (
      SELECT 
        CASE 
        WHEN therm_dataset_id = $datasetsensor2::INTEGER  THEN 'ext'
        WHEN therm_dataset_id = $datasetsensor1::INTEGER THEN 'int' 
        END as type,
        MAX(therm_data_rh) as tmax,
        MIN(therm_data_rh) as tmin
      FROM therm_data
      WHERE therm_dataset_id IN ($datasetsensor2::INTEGER, $datasetsensor1::INTEGER)
    AND (therm_data_date + therm_data_hour)::timestamp BETWEEN $crossanalysis_period_start::timestamp  AND $crossanalysis_period_end::timestamp
      GROUP BY therm_dataset_id
    )
    SELECT 
      (MAX(CASE WHEN type = 'int' THEN tmax END) - MAX(CASE WHEN type = 'int' THEN tmin END)) / 
      NULLIF(MAX(CASE WHEN type = 'ext' THEN tmax END) - MAX(CASE WHEN type = 'ext' THEN tmin END), 0)
    * 100
    FROM amps
  )::numeric(5,1) as facteur_amortissement_rh,

ABS($phase_shift_hours_rh::numeric) as therm_delta_rh,

    (
    SELECT stddev(therm_data_rh)::numeric(10,2)
    FROM therm_data
    WHERE therm_dataset_id = :datasetsensor1::integer
    AND therm_data_date + therm_data_hour BETWEEN $crossanalysis_period_start::timestamp AND $crossanalysis_period_end::timestamp
    ) as therm_ecart_type1_rh,

 (
        SELECT stddev(therm_data_rh)::numeric(10,2)
        FROM therm_data
        WHERE therm_dataset_id = :datasetsensor2::integer
        AND therm_data_date + therm_data_hour BETWEEN $crossanalysis_period_start::timestamp AND $crossanalysis_period_end::timestamp
    ) as therm_ecart_type2_rh;

