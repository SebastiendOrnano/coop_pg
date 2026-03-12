SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SET therm_set_sensor_id = SELECT therm_set_sensor_id FROM therm_dataset  WHERE therm_dataset_id = $therm_dataset_id::integer;
SET therm_set_id = SELECT therm_set_id FROM therm_set_sensor WHERE therm_set_sensor_id=$therm_set_sensor_id::INTEGER;
SET room_id = (SELECT room_id FROM therm_set WHERE therm_set_id = $therm_set_id::integer);
SET building_id = (SELECT building_id  FROM project_building_rooms  WHERE room_id = $room_id::integer);
SET project_id = (SELECT project_id  FROM project_building  WHERE building_id = $building_id::integer);


SET date_start_mini1 = (SELECT MIN(therm_data_date) FROM therm_data WHERE therm_dataset_id=$therm_dataset_id::INTEGER);
SET date_end_max1 = (SELECT MAX(therm_data_date) FROM therm_data WHERE  therm_dataset_id=$therm_dataset_id::INTEGER);
SET hour_start_mini1 = (SELECT MIN(therm_data_hour) FROM therm_data WHERE therm_dataset_id=$therm_dataset_id::INTEGER AND therm_data_date=$date_start_mini1::DATE);
SET hour_end_max1 = (SELECT MAX(therm_data_hour) FROM therm_data WHERE therm_dataset_id=$therm_dataset_id::INTEGER AND therm_data_date=$date_end_max1::DATE);



SET Dataset_Name = (SELECT therm_dataset_name FROM therm_dataset WHERE therm_dataset_id=$therm_dataset_id::INTEGER);

SELECT 
    'text' as component;
SELECT 
    'Recap données du dataset : '||$Dataset_Name as contents,
    TRUE  as bold,
    3 as size,
    TRUE  as italics;



SELECT 
    'datagrid1'              as component,
    'panel_therm_display' as id;

SELECT 
   'javascript:printdivchart()'  AS link,
    'Print'              as description,
    'printer'                                     as icon,
    'red'                                       as color;
SELECT 
     '/e_project_therm/therm_dataset_csv_0.sql?therm_dataset_id='||$therm_dataset_id            as link,
    'All data csv'           as description,
    'download'                                     as icon,
    'green'                                              as color;
SELECT 
     '/e_project_therm/therm_dataset_csv_recap_0.sql?therm_dataset_id='||$therm_dataset_id            as link,
    'Summary csv'           as description,
    'download'                                     as icon,
    'blue'      as color;
SELECT 
    'javascript:chartexportsvg_datagrid()'  AS link,
    'chartexporttempsvg'          AS row_id,
    'Exporter Temp en SVG'         as description,
    'download'                AS icon,
    'green' AS color;
SELECT 
   'javascript:chartexportsvg_datagrid()'  AS link,
   'chartexportrhsvg' AS row_id,   -- pour RH
   'Exporter RH en SVG' as description,
   'download' AS icon,
   'blue' AS color;



SELECT 
    'form' as component,
    'recap_dataset'   as id,
    '' as validate;


SELECT
    'therm_data_count' as name,
    'text' as type,  
    'Nb data' as label,
    true as readonly,
    (SELECT COUNT(therm_data_temp)  FROM therm_data WHERE therm_dataset_id=$therm_dataset_id::integer ) AS value,
   3 AS width;

SELECT
    'therm_interval' AS name,
    'text' AS type,
    'Interval moy' AS label,
       (SELECT AVG(diff_minutes)::numeric(2,0) AS avg_minutes
        FROM (
            SELECT
                EXTRACT(EPOCH FROM (
                    (therm_data_date + therm_data_hour) - 
                    LAG(therm_data_date + therm_data_hour) OVER (ORDER BY therm_data_date + therm_data_hour)
                )) / 60 AS diff_minutes
            FROM therm_data 
            WHERE therm_dataset_id = $therm_dataset_id::integer 
        ) t
    ) AS value,
    'mn' as prefix,
   3  AS width;
   
SELECT
    'therm_dataset_name' as name,
    'text' as type,  
    'Dataset Name' as label,
    true as readonly,
    (SELECT therm_dataset_name FROM therm_dataset WHERE therm_dataset_id=$therm_dataset_id::INTEGER) AS value,
    3 AS width;

SELECT
    'date_start_mini' as name,
    'text' as type,  
    'Date début' as label,
    3 AS width,
    $date_start_mini1 as value,
    TRUE as readonly;

SELECT
    'date_end_max' as name,
    'text' as type,  
    'Date fin' as label,
    3 AS width,
    $date_end_max1 as value,
    TRUE as readonly;

SELECT
    'therm_data_temp' as name,
    'text' as type,  
    'Temp Max' as label,
    true as readonly,
    '°C' as prefix,
    (SELECT (COALESCE(MAX(therm_data_temp), 0)::numeric(10,2)) FROM therm_data WHERE therm_dataset_id = $therm_dataset_id::integer) AS value,
    3AS width;

SELECT
    'therm_data_temp' as name,
    'text' as type,  
    'Temp Mini' as label,
    true as readonly,
    '°C' as prefix,
    (SELECT (COALESCE(MIN(therm_data_temp), 0)::numeric(10,2)) FROM therm_data WHERE therm_dataset_id=$therm_dataset_id::INTEGER) AS value,
    3 AS width;

SELECT
    'therm_data_temp' as name,
    'text' as type,  
    'Temp Moy' as label,
    true as readonly,
    '°C' as prefix,
    (SELECT AVG(therm_data_temp)::numeric(10,2) FROM therm_data WHERE therm_dataset_id=$therm_dataset_id::INTEGER) AS value,
    3 AS width;


SELECT
    'therm_ecart_type' AS name,
    'text' AS type,
    'Ecart-type Temp' AS label,
    true AS readonly,
    (
        SELECT stddev(therm_data_temp)::numeric(10,2)
        FROM therm_data
        WHERE therm_dataset_id=$therm_dataset_id::INTEGER
    ) AS value,
   3 AS width;


SELECT
    'therm_data_rh' as name,
    'text' as type,
    'RH max' as label,
    true as readonly,
    '%' as prefix,
    (SELECT MAX(therm_data_rh)::numeric(10,2) FROM therm_data WHERE therm_dataset_id=$therm_dataset_id::INTEGER) AS value,
    3 as width;
SELECT
    'therm_data_rh' as name,
    'text' as type,
    'RH mini' as label,
    true as readonly,
    '%' as prefix,
    (SELECT MIN(therm_data_rh)::numeric(10,2)  FROM therm_data WHERE therm_dataset_id=$therm_dataset_id::INTEGER) AS value,
    3 as width;

SELECT
    'therm_data_rh' as name,
    'text' as type,
    'RH moy' as label,
    true as readonly,
    '%' as prefix,
    (SELECT AVG(therm_data_rh)::numeric(10,2)  FROM therm_data WHERE therm_dataset_id=$therm_dataset_id::INTEGER) AS value,
    3 as width;
SELECT
    'therm_ecart_type' AS name,
    'text' AS type,
    'Ecart-type RH' AS label,
    true AS readonly,
    (
        SELECT stddev(therm_data_rh)::numeric(10,2)
        FROM therm_data
        WHERE therm_dataset_id=$therm_dataset_id::INTEGER
    ) AS value,
   3 AS width;
/*
SELECT
    'therm_data_co2' as name,
    'text' as type,  
    'CO2 max' as label,
    true as readonly,
    'ppm' as prefix,
    (SELECT MAX(therm_data_co2)  FROM therm_data WHERE therm_dataset_id=$therm_dataset_id::integer ) AS value,
    3 as width;

SELECT
    'therm_data_co2' as name,
    'text' as type,  
    'CO2 mini' as label,
    true as readonly,
    'ppm' as prefix,
    (SELECT MAX(therm_data_co2) FROM therm_data WHERE therm_dataset_id=$therm_dataset_id::integer ) AS value,
    3 as width;

SELECT
    'therm_data_co2' as name,
    'text' as type,  
    'CO2 moy' as label,
    true as readonly,
    'ppm' as prefix,
    (SELECT MAX(therm_data_co2) FROM therm_data WHERE therm_dataset_id=$therm_dataset_id::integer ) AS value,
    3 as width;
*/

SELECT 
    'chart'            AS component,
    'Temp'             AS title,
    'chart_temp'        AS id,
    'area'             AS type,
     true              AS time,
     true              as date,
    'green'            AS color;
SELECT 
    therm_data_temp::TEXT  AS y,
    therm_data_date + therm_data_hour AS x
    FROM therm_data  WHERE therm_dataset_id = $therm_dataset_id::integer ;

SELECT 
    'chart'            AS component,
    'RH'          AS title,
    'chart_rh'        AS id,
    'area'             AS type,
    TRUE               AS time,
    true               as date,
   'blue'             AS color;
SELECT 

    therm_data_rh     AS y,
    therm_data_date + therm_data_hour AS x
    FROM therm_data  WHERE therm_dataset_id = $therm_dataset_id::integer ;


