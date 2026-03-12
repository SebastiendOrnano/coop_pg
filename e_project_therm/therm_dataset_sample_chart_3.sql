SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_3.sql') AS properties;

SET therm_dataset_id = SELECT therm_dataset_id from therm_dataset_sample  WHERE therm_dataset_sample_id = $therm_dataset_sample_id::integer;
SET therm_set_sensor_id = SELECT therm_set_sensor_id FROM therm_dataset  WHERE therm_dataset_id = $therm_dataset_id::integer
SET therm_set_id = SELECT therm_set_id FROM therm_set_sensor WHERE therm_set_sensor_id=$therm_set_sensor_id::INTEGER;
SET room_id = (SELECT room_id FROM therm_set WHERE therm_set_id = $therm_set_id::integer);
SET building_id = (SELECT building_id  FROM project_building_rooms  WHERE room_id = $room_id::integer);
SET project_id = (SELECT project_id  FROM project_building  WHERE building_id = $building_id::integer);


SET period_start = (
  SELECT
    (therm_dataset_sample_date_start::date 
     + therm_dataset_sample_hour_start::time)::timestamp
  FROM therm_dataset_sample
  WHERE therm_dataset_sample_id = $therm_dataset_sample_id::integer
);
SET period_end = (
    SELECT
     (therm_dataset_sample_date_end::DATE
     +therm_dataset_sample_hour_end::TIME)::TIMESTAMP
     FROM therm_dataset_sample 
     WHERE therm_dataset_sample_id= $therm_dataset_sample_id::INTEGER
);


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
    'Hub du projet'            as title,
    '/e_project/project_hub_display_3.sql?project_id='||$project_id     as link;   
SELECT 
    'Campagnes mesure'            as title,
    '/e_project_therm/therm_set_display_3.sql?project_id='||$project_id     as link;
 SELECT 
    'Capteur'            as title,
    '/e_project_therm/therm_set_sensor_display_3.sql?therm_set_id='||$therm_set_id     as link;  
 SELECT 
    'Graph complet'            as title,
    '/e_project_therm/therm_dataset_chart_3.sql?therm_dataset_id='||$therm_dataset_id     as link;  




SELECT 
    'datagrid1'              as component,
    'panel_therm_data_sample_display' as id;
SELECT 
     '/e_project_therm/therm_dataset_sample_csv_0.sql?therm_dataset_id='||$therm_dataset_id    as link,
    'Télécharger les données csv'                 as description,
    'download'                                     as icon,
    'green'                                        as color;
SELECT 
     '/e_project_therm/therm_dataset_sample_csv_recap_0.sql?therm_dataset_id='||$therm_dataset_id   as link,
    'Télécharger la récap des données en csv'           as description,
    'download'                                          as icon,
    'blue'                                              as color;
SELECT 
   'javascript:printdivchart()'  AS link,
    'imprimer les données'              as description,
    'printer'                                     as icon,
    'red'                                       as color;
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
    'Cadre de l''analyse d''une période spécifique' as title,
    'recap_dataset'   as id,
    '' as validate;

SELECT
    'therm_set_name' as name,
    'text' as type,  
    'Campagne' as label,
    true as readonly,
    (SELECT s.therm_set_name 
     FROM therm_set AS s
     LEFT JOIN (SELECT therm_set_id, therm_set_sensor_id FROM therm_set_sensor) AS t
    ON s.therm_set_id = t.therm_set_id 
     LEFT JOIN (SELECT therm_set_sensor_id, therm_dataset_id FROM therm_dataset) AS d
    ON d.therm_set_sensor_id = t.therm_set_sensor_id    
     WHERE d.therm_dataset_id = $therm_dataset_id::INTEGER
    ) AS value,
    4 AS width;


 SELECT
    'therm_dataset_sample_date_start' as name,
    'text' as type,  
    'Date fin' as label,
    2 AS width,
    (SELECT therm_dataset_sample_date_start FROM therm_dataset_sample WHERE therm_dataset_sample_id= $therm_dataset_sample_id::INTEGER
    
    )  as value,
    TRUE as readonly;

SELECT
    'therm_dataset_sample_hour_start' as name,
    'text' as type,  
    'Date fin' as label,
    2 AS width,
    (SELECT therm_dataset_sample_hour_start FROM therm_dataset_sample WHERE therm_dataset_sample_id= $therm_dataset_sample_id::INTEGER)  as value,
    TRUE as readonly;

 SELECT
    'therm_dataset_sample_date_end' as name,
    'text' as type,  
    'Date fin' as label,
    2 AS width,
    (SELECT therm_dataset_sample_date_end FROM therm_dataset_sample WHERE therm_dataset_sample_id= $therm_dataset_sample_id::INTEGER)  as value,
    TRUE as readonly;

SELECT
    'therm_dataset_sample_hour_end' as name,
    'text' as type,  
    'Date fin' as label,
    2 AS width,
    (SELECT therm_dataset_sample_hour_end FROM therm_dataset_sample WHERE therm_dataset_sample_id= $therm_dataset_sample_id::INTEGER)  as value,
    TRUE as readonly;

SELECT
    'building_name' as name,
    'text' as type,  
    'Bâtiment' as label,
    true as readonly,
    (SELECT s.building_name 
    FROM project_building AS s
    LEFT JOIN (SELECT building_id, room_id FROM project_building_rooms) AS b
    ON s.building_id = b.building_id 
    LEFT JOIN (SELECT therm_set_id, room_id FROM therm_set) AS r
    ON b.room_id = r.room_id 
    LEFT JOIN (SELECT therm_set_id, therm_set_sensor_id FROM therm_set_sensor) AS t
    ON r.therm_set_id = t.therm_set_id 
    LEFT JOIN (SELECT therm_set_sensor_id, therm_dataset_id FROM therm_dataset) AS d
    ON d.therm_set_sensor_id = t.therm_set_sensor_id    
     WHERE d.therm_dataset_id = $therm_dataset_id::INTEGER
    ) AS value,
    2 AS width;


SELECT
    'room_name' as name,
    'text' as type,  
    'Lieu' as label,
    true as readonly,
    (SELECT s.room_name 
    FROM project_building_rooms AS s
    LEFT JOIN (SELECT therm_set_id, room_id FROM therm_set) AS r
    ON s.room_id = r.room_id 
    LEFT JOIN (SELECT therm_set_id, therm_set_sensor_id FROM therm_set_sensor) AS t
    ON r.therm_set_id = t.therm_set_id 
    LEFT JOIN (SELECT therm_set_sensor_id, therm_dataset_id FROM therm_dataset) AS d
    ON d.therm_set_sensor_id = t.therm_set_sensor_id    
     WHERE d.therm_dataset_id = $therm_dataset_id::INTEGER
    ) AS value,
    2 AS width;

SELECT
    'therm_dataset_id' as name,
    'text' as type,  
    'Dataset id' as label,
    true as readonly,
   $therm_dataset_id AS value,
   1 AS width;

SELECT
    'therm_dataset_name' as name,
    'text' as type,  
    'Dataset Name' as label,
    true as readonly,
    (SELECT therm_dataset_name FROM therm_dataset WHERE therm_dataset_id=$therm_dataset_id::INTEGER) AS value,
    2 AS width;


SELECT
    'therm_sensor_name' as name,
    'text' as type,  
    'Capteur' as label,
    true as readonly,
    (SELECT s.therm_sensor_name 
     FROM therm_sensor AS s
     LEFT JOIN (SELECT therm_sensor_id, therm_set_sensor_id FROM therm_set_sensor) AS t
    ON s.therm_sensor_id = t.therm_sensor_id 
     LEFT JOIN (SELECT therm_set_sensor_id, therm_dataset_id FROM therm_dataset) AS d
    ON d.therm_set_sensor_id = t.therm_set_sensor_id    
     WHERE d.therm_dataset_id = $therm_dataset_id::INTEGER
    ) AS value,
    2 AS width;

SELECT 
    'form' as component,
    'Récap des mesures / analyse d''une période spécifique' as title,
    'recap_dataset'   as id,
    '' as validate;

SELECT
    'therm_data_count' as name,
    'text' as type,  
    'Nb data' as label,
    true as readonly,
    (
        SELECT COUNT(therm_data_temp)  
        FROM therm_data
        WHERE therm_dataset_id = $therm_dataset_id::integer
        AND therm_data_date + therm_data_hour BETWEEN $period_start::timestamp AND $period_end::timestamp
    ) AS value,
    1 AS width;

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
        AND therm_data_date + therm_data_hour BETWEEN $period_start::timestamp AND $period_end::timestamp
        ) t
    ) AS value,
    'mn' as prefix,
     2 AS width;

SELECT
    'therm_data_temp' AS name,
    'text' AS type,  
    'Temp Max' AS label,
    TRUE AS readonly,
    '°C' AS prefix,
    (
        SELECT COALESCE(MAX(therm_data_temp), 0)::numeric(10,2)
        FROM therm_data
        WHERE therm_dataset_id = $therm_dataset_id::integer
        AND therm_data_date + therm_data_hour BETWEEN $period_start::timestamp AND $period_end::timestamp
    ) AS value,
    2 AS width;

SELECT
    'therm_data_temp' as name,
    'text' as type,  
    'Temp Mini' as label,
    true as readonly,
    '°C' as prefix,
    (SELECT (COALESCE(MIN(therm_data_temp), 0)::numeric(10,2)) 
        FROM therm_data
        WHERE therm_dataset_id = $therm_dataset_id::integer
        AND therm_data_date + therm_data_hour BETWEEN $period_start::timestamp AND $period_end::timestamp
    ) AS value,
    2 AS width;

SELECT
    'therm_data_temp' as name,
    'text' as type,  
    'Temp Moy' as label,
    true as readonly,
    '°C' as prefix,
    (
    SELECT AVG(therm_data_temp)::numeric(10,2) 
        FROM therm_data
        WHERE therm_dataset_id = $therm_dataset_id::integer
        AND therm_data_date + therm_data_hour BETWEEN $period_start::timestamp AND $period_end::timestamp
    ) AS value,
    2 AS width;
SELECT
    'therm_ecart_type' AS name,
    'text' AS type,
    'Ecart-type Temp' AS label,
    true AS readonly,
    (
        SELECT stddev(therm_data_temp)::numeric(10,2)
        FROM therm_data
        WHERE therm_dataset_id = $therm_dataset_id::integer
        AND therm_data_date + therm_data_hour BETWEEN $period_start::timestamp AND $period_end::timestamp
    ) AS value,
   2 AS width;
SELECT
    'therm_data_rh' as name,
    'text' as type,
    'RH max' as label,
    true as readonly,
    '%' as prefix,
    (
        SELECT MAX(therm_data_rh)::numeric(10,2) 
        FROM therm_data
        WHERE therm_dataset_id = $therm_dataset_id::integer
        AND therm_data_date + therm_data_hour BETWEEN $period_start::timestamp AND $period_end::timestamp
    ) AS value,
    2 as width;
SELECT
    'therm_data_rh' as name,
    'text' as type,
    'RH mini' as label,
    true as readonly,
    '%' as prefix,
    (
        SELECT MIN(therm_data_rh)::numeric(10,2)  
        FROM therm_data
        WHERE therm_dataset_id = $therm_dataset_id::integer
        AND therm_data_date + therm_data_hour BETWEEN $period_start::timestamp AND $period_end::timestamp
    ) AS value,
    2 as width;
SELECT
    'therm_data_rh' as name,
    'text' as type,
    'RH moy' as label,
    true as readonly,
    '%' as prefix,
    (
        SELECT AVG(therm_data_rh)::numeric(10,2)  
        FROM therm_data
        WHERE therm_dataset_id = $therm_dataset_id::integer
        AND therm_data_date + therm_data_hour BETWEEN $period_start::timestamp AND $period_end::timestamp
    ) AS value,
    2 as width;
SELECT
    'therm_ecart_type' AS name,
    'text' AS type,
    'Ecart-type RH' AS label,
    true AS readonly,
    (
        SELECT stddev(therm_data_rh)::numeric(10,2)
        FROM therm_data
        WHERE therm_dataset_id=$therm_dataset_id::INTEGER
        AND therm_data_date + therm_data_hour BETWEEN $period_start::timestamp AND $period_end::timestamp
    ) AS value,
   2 AS width;
   /*
SELECT
    'therm_data_co2' as name,
    'text' as type,  
    'CO2 max' as label,
    true as readonly,
    'ppm' as prefix,
    (
        SELECT MAX(therm_data_co2)
        FROM therm_data
        WHERE therm_dataset_id = $therm_dataset_id::integer
        AND therm_data_date + therm_data_hour BETWEEN $period_start::timestamp AND $period_end::timestamp
    ) AS value,
    2 as width;

SELECT
    'therm_data_co2' as name,
    'text' as type,  
    'CO2 mini' as label,
    true as readonly,
    'ppm' as prefix,
    (
        SELECT MAX(therm_data_co2) 
        FROM therm_data
        WHERE therm_dataset_id = $therm_dataset_id::integer
        AND therm_data_date + therm_data_hour BETWEEN $period_start::timestamp AND $period_end::timestamp
    ) AS value,
    2 as width;

SELECT
    'therm_data_co2' as name,
    'text' as type,  
    'CO2 moy' as label,
    true as readonly,
    'ppm' as prefix,
    (
        SELECT MAX(therm_data_co2) 
        FROM therm_data
        WHERE therm_dataset_id = $therm_dataset_id::integer
        AND therm_data_date + therm_data_hour BETWEEN $period_start::timestamp AND $period_end::timestamp
    ) AS value,
    2 as width;
*/
SELECT 
    'chart'            AS component,
    'Temp'             AS title,
    'chart_temp'       AS id,
    'area'             AS type,
     true              AS time,
     true              as date,
    'green'            AS color;
SELECT 
    therm_data_temp::TEXT  AS y,
    therm_data_date + therm_data_hour AS x
    FROM therm_data  
    WHERE (therm_data_date::DATE + therm_data_hour::TIME) BETWEEN $period_start::TIMESTAMP AND $period_end::TIMESTAMP
    AND therm_dataset_id = $therm_dataset_id::integer;

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
    FROM therm_data 
    WHERE (therm_data_date::DATE + therm_data_hour::TIME) BETWEEN $period_start::TIMESTAMP AND $period_end::TIMESTAMP
    AND therm_dataset_id = $therm_dataset_id::integer;


