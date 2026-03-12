SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SET therm_set_sensor_id = SELECT therm_set_sensor_id FROM therm_dual_analysis  WHERE dual_analysis_id=$dual_analysis_id::INTEGER;
SET room_id = (SELECT room_id FROM therm_set WHERE therm_set_id = $therm_set_id::integer);
SET building_id = (SELECT building_id  FROM project_building_rooms  WHERE room_id = $room_id::integer);
SET project_id = (SELECT project_id  FROM project_building  WHERE building_id = $building_id::integer);


SELECT 
    'breadcrumb' as component;
SELECT 
    'Home' as title,
    '/'    as link;
SELECT 
    'Gestion Superviseur'         as title,
    '/a_panels/panel_supervisor_4.sql' as link;
 SELECT 
    'liste des projets'            as title,
    '/e_project/project_main_display_4.sql'     as link;   
 SELECT 
    'hub du projet'            as title,
    '/e_project/project_hub_display_4.sql?project_id='||$project_id     as link;   
 SELECT 
    'Campagne de mesure'            as title,
    '/e_project_therm/therm_set_display_4.sql?project_id='||$project_id     as link;   
 SELECT 
    'Capteur'            as title,
    '/e_project_therm/therm_set_sensor_display_4.sql?therm_set_id='||$therm_set_id     as link;   
SELECT 
    'periode complète'            as title,
    '/e_project_therm/therm_set_sensor_dual_analysis_chart_4.sql?therm_set_id='||$therm_set_id   as link;

SET date_start_min1 = SELECT MIN(therm_data_date) 
FROM therm_data as d
LEFT JOIN (select dual_analysis_id, dataset1_id, dataset2_id  FROM therm_dual_analysis) as t
ON  d.therm_dataset_id=t.dataset1_id
WHERE t.dual_analysis_id=$dual_analysis_id::INTEGER;

SET date_end_max1 = SELECT MAX(therm_data_date) 
FROM therm_data as d
LEFT JOIN (select dual_analysis_id, dataset1_id, dataset2_id  FROM therm_dual_analysis) as t
ON  d.therm_dataset_id=t.dataset1_id
WHERE t.dual_analysis_id=$dual_analysis_id::INTEGER;

SET date_start_min2 = SELECT MIN(therm_data_date) 
FROM therm_data as d
LEFT JOIN (select dual_analysis_id, dataset1_id, dataset2_id  FROM therm_dual_analysis) as t
ON  d.therm_dataset_id=t.dataset2_id
WHERE t.dual_analysis_id=$dual_analysis_id::INTEGER;

SET date_end_max2 = SELECT MAX(therm_data_date) 
FROM therm_data as d
LEFT JOIN (select dual_analysis_id, dataset1_id, dataset2_id  FROM therm_dual_analysis) as t
ON  d.therm_dataset_id=t.dataset2_id
WHERE t.dual_analysis_id=$dual_analysis_id::INTEGER;

SET hour_start_min1 = SELECT MIN(therm_data_hour) 
FROM therm_data as d
LEFT JOIN (select dual_analysis_id, dataset1_id, dataset2_id  FROM therm_dual_analysis) as t
ON  d.therm_dataset_id=t.dataset1_id
WHERE t.dual_analysis_id=$dual_analysis_id::INTEGER 
AND d.therm_data_date=$date_start_min1::DATE;

SET hour_end_max1 = SELECT MAX(therm_data_hour) 
FROM therm_data as d
LEFT JOIN (select dual_analysis_id, dataset1_id, dataset2_id  FROM therm_dual_analysis) as t
ON  d.therm_dataset_id=t.dataset1_id
WHERE t.dual_analysis_id=$dual_analysis_id::INTEGER 
AND d.therm_data_date=$date_end_max1::DATE;

SET hour_start_min2 = SELECT MIN(therm_data_hour) 
FROM therm_data as d
LEFT JOIN (select dual_analysis_id, dataset1_id, dataset2_id  FROM therm_dual_analysis) as t
ON  d.therm_dataset_id=t.dataset2_id
WHERE t.dual_analysis_id=$dual_analysis_id::INTEGER 
AND d.therm_data_date=$date_start_min2::DATE;

SET hour_end_max2 = SELECT MAX(therm_data_hour) 
FROM therm_data as d
LEFT JOIN (select dual_analysis_id, dataset1_id, dataset2_id  FROM therm_dual_analysis) as t
ON  d.therm_dataset_id=t.dataset2_id
WHERE t.dual_analysis_id=$dual_analysis_id::INTEGER 
AND d.therm_data_date=$date_end_max2::DATE;

SET dual_analysis_period_start1 = SELECT MIN(therm_data_date + therm_data_hour) 
FROM therm_data as d
LEFT JOIN (select dual_analysis_id, dataset1_id, dataset2_id  FROM therm_dual_analysis) as t
ON  d.therm_dataset_id=t.dataset1_id
WHERE t.dual_analysis_id=$dual_analysis_id::INTEGER LIMIT 1;

SET dual_analysis_period_end1 = SELECT MAX(therm_data_date + therm_data_hour) 
FROM therm_data as d
LEFT JOIN (select dual_analysis_id, dataset1_id, dataset2_id  FROM therm_dual_analysis) as t
ON  d.therm_dataset_id=t.dataset1_id
WHERE t.dual_analysis_id=$dual_analysis_id::INTEGER LIMIT 1;

SET dual_analysis_period_start2 = SELECT MIN(therm_data_date + therm_data_hour) 
FROM therm_data as d
LEFT JOIN (select dual_analysis_id, dataset1_id, dataset2_id  FROM therm_dual_analysis) as t
ON  d.therm_dataset_id=t.dataset1_id
WHERE t.dual_analysis_id=$dual_analysis_id::INTEGER LIMIT 1;

SET dual_analysis_period_end2 = SELECT MAX(therm_data_date + therm_data_hour) 
FROM therm_data as d
LEFT JOIN (select dual_analysis_id, dataset1_id, dataset2_id  FROM therm_dual_analysis) as t
ON  d.therm_dataset_id=t.dataset1_id
WHERE t.dual_analysis_id=$dual_analysis_id::INTEGER LIMIT 1;



SELECT 
    'form' as component,
    'Définir les échantillons de données sur dataset 1 et/ou dataset 2' as title,
    'Créer' as validate,
    'Clear' as reset,
    '/e_project_therm/therm_dual_analysis_sample_create_0.sql?dual_analysis_id='||$dual_analysis_id as action;

SELECT
    'therm_set_sensor_id' as name,
    'hidden'      as type,
   (SELECT therm_set_sensor_id FROM therm_dual_analysis WHERE dual_analysis_id=$dual_analysis_id::INTEGER)  AS value;
SELECT
    'dual_analysis_id' as name,
    'hidden'      as type,
    $dual_analysis_id::INTEGER  AS value;
SELECT
    'dataset1' as name,
    'hidden'      as type,
    (SELECT dataset1_id FROM therm_dual_analysis WHERE dual_analysis_id=$dual_analysis_id::INTEGER)  AS value;
SELECT
    'dataset2' as name,
    'hidden'      as type,
    (SELECT dataset2_id FROM therm_dual_analysis WHERE dual_analysis_id=$dual_analysis_id::INTEGER)  AS value;
SELECT
    'dataset1_name' as name,
    'DATASET 1 ' as label,
    'text'      as type,
       12 as width,
    (SELECT therm_dataset_name from therm_dataset  as d
LEFT JOIN (select dual_analysis_id, dataset1_id, dataset2_id  FROM therm_dual_analysis) as t
ON  d.therm_dataset_id=t.dataset1_id
WHERE t.dual_analysis_id=$dual_analysis_id::INTEGER) as value;
SELECT
    'date_start_min1' as name,
    'text' as type,  
    'Dataset 1: date début' as label,
    3 AS width,
    $date_start_min1::DATE as value,
    TRUE as readonly;
SELECT
    'hour_start_min1' as name,
    'text' as type,  
    'Dataset 1: heure début' as label,
    3 AS width,
    $hour_start_min1::TIME as value,
    TRUE as readonly;
SELECT
    'date_end_max1' as name,
    'text' as type,  
    'Dataset 1: date fin' as label,
    3 AS width,
    $date_end_max1::DATE as value,
    TRUE as readonly;
SELECT
    'hour_end_max1' as name,
    'text' as type,  
    'Dataset 1: heure fin' as label,
    3 AS width,
    $hour_end_max1::TIME as value,
    TRUE as readonly;
 
SELECT
    'sample_day_start1'                 as name,
    'Dataset 1 Jour début analyse'          as label,
    'select'                                as type,
    3                                      AS width,
    'Choisir une date dans la liste...'    AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label', date_jour, 'value', date_jour)) AS options
FROM (
    SELECT generate_series(
        DATE($dual_analysis_period_start1), 
        DATE($dual_analysis_period_end1), 
        INTERVAL '1 day'
    )::date AS date_jour
    FROM therm_dual_analysis 
    WHERE dual_analysis_id=$dual_analysis_id::INTEGER
    ORDER BY date_jour
) AS dates;

SELECT 
    'sample_hour_start1' AS name,
    'Dataset 1 : Heure début analyse'       AS label,
    'select'                      AS type,
    3                            AS width,
    'Choisir une heure dans la liste...'    AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label', i.choice_label, 'value', i.choice_value) ORDER BY i.choice_value) AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='list_hours' ;
SELECT
    'sample_day_end1'                 as name,
    'Dataset 1: Date fin analyse'          as label,
    'select'                                as type,
    3                                      AS width,
    'Choisir une date dans la liste...'    AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label', date_jour, 'value', date_jour)) AS options
FROM (
    SELECT generate_series(
        DATE($dual_analysis_period_start1), 
        DATE($dual_analysis_period_end1), 
        INTERVAL '1 day'
    )::date AS date_jour
    FROM therm_dual_analysis 
   WHERE dual_analysis_id=$dual_analysis_id::INTEGER
    ORDER BY date_jour
) AS dates;

SELECT 
    'sample_hour_end1' AS name,
    'Dataset 1: Heure fin analyse'       AS label,
    'select'                      AS type,
    3                            AS width,
    'Choisir une heure dans la liste...'    AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label', i.choice_label, 'value', i.choice_value) ORDER BY i.choice_value) AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='list_hours' ;


SELECT
    'dataset2_name' as name,
    'DATASET 2' as label,
    'text'      as type,
       12 as width,
    (SELECT therm_dataset_name from therm_dataset  as d
LEFT JOIN (select dual_analysis_id, dataset1_id, dataset2_id  FROM therm_dual_analysis) as t
ON  d.therm_dataset_id=t.dataset2_id
WHERE t.dual_analysis_id=$dual_analysis_id::INTEGER) as value;



SELECT
    'date_start_min2' as name,
    'text' as type,  
    'Dataset 2: date début' as label,
    3 AS width,
    $date_start_min2::DATE as value,
    TRUE as readonly;

SELECT
    'hour_start_min2' as name,
    'text' as type,  
    'Dataset 2: heure début' as label,
    3 AS width,
    $hour_start_min2::TIME as value,
    TRUE as readonly;

 SELECT
    'date_end_max2' as name,
    'text' as type,  
    'Dataset 1: date fin' as label,
    3 AS width,
    $date_end_max1::DATE as value,
    TRUE as readonly;

SELECT
    'hour_end_max2' as name,
    'text' as type,  
    'Dataset 2: heure fin' as label,
    3 AS width,
    $hour_end_max1::TIME as value,
    TRUE as readonly;
 
SELECT
    'sample_day_start2'                 as name,
    'Dataset 2: Jour début analyse'          as label,
    'select'                                as type,
    3                                      AS width,
    'Choisir une date dans la liste...'    AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label', date_jour, 'value', date_jour)) AS options
FROM (
    SELECT generate_series(
        DATE($dual_analysis_period_start2), 
        DATE($dual_analysis_period_end2), 
        INTERVAL '1 day'
    )::date AS date_jour
    FROM therm_dual_analysis 
    WHERE dual_analysis_id=$dual_analysis_id::INTEGER
    ORDER BY date_jour
) AS dates;

SELECT 
    'sample_hour_start2' AS name,
    'Dataset 1 : Heure début analyse'       AS label,
    'select'                      AS type,
    3                            AS width,
    'Choisir une heure dans la liste...'    AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label', i.choice_label, 'value', i.choice_value) ORDER BY i.choice_value) AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='list_hours' ;
SELECT
    'sample_day_end2'                 as name,
    'Dataset 2: Date fin analyse'          as label,
    'select'                                as type,
    3                                      AS width,
    'Choisir une date dans la liste...'    AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label', date_jour, 'value', date_jour)) AS options
FROM (
    SELECT generate_series(
        DATE($dual_analysis_period_start2), 
        DATE($dual_analysis_period_end2), 
        INTERVAL '1 day'
    )::date AS date_jour
    FROM therm_dual_analysis 
   WHERE dual_analysis_id=$dual_analysis_id::INTEGER
    ORDER BY date_jour
) AS dates;

SELECT 
    'sample_hour_end2' AS name,
    'Dataset 2: Heure fin analyse'       AS label,
    'select'                      AS type,
    3                            AS width,
    'Choisir une heure dans la liste...'    AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label', i.choice_label, 'value', i.choice_value) ORDER BY i.choice_value) AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='list_hours' ;
