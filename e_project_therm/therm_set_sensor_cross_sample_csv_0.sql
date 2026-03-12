SET therm_set_id = SELECT therm_set_id FROM therm_crossanalysis WHERE crossanalysis_id=$crossanalysis_id::INTEGER;
SET room_id = (SELECT room_id FROM therm_set WHERE therm_set_id = $therm_set_id::integer);
SET building_id = (SELECT building_id  FROM project_building_rooms  WHERE room_id = $room_id::integer);
SET project_id = (SELECT project_id  FROM project_building  WHERE building_id = $building_id::integer);

SET crossanalysis_id = SELECT crossanalysis_id FROM therm_crossanalysis_sample WHERE crossanalysis_sample_id=$crossanalysis_sample_id::INTEGER;

SET datasetsensor1 = SELECT datasetsensor1 FROM therm_crossanalysis WHERE crossanalysis_id=$crossanalysis_id::INTEGER;
SET datasetsensor2 = SELECT datasetsensor2 FROM therm_crossanalysis WHERE crossanalysis_id=$crossanalysis_id::INTEGER;
SET period_start = SELECT crossanalysis_period_start FROM therm_crossanalysis WHERE crossanalysis_id=$crossanalysis_id::INTEGER;
SET period_end = SELECT crossanalysis_period_end FROM therm_crossanalysis WHERE crossanalysis_id=$crossanalysis_id::INTEGER;

SET therm_dataset_id =
SELECT 
CASE 
WHEN $datasetsensor::text = '1' THEN $datasetsensor1
ELSE $datasetsensor2
END;

SET sample_period_start = SELECT (crossanalysis_sample_date_start::date + crossanalysis_sample_hour_start::time)::timestamp FROM therm_crossanalysis_sample WHERE crossanalysis_sample_id=$crossanalysis_sample_id::INTEGER;
SET sample_period_end = SELECT (crossanalysis_sample_date_end::date + crossanalysis_sample_hour_end::time)::timestamp FROM therm_crossanalysis_sample WHERE crossanalysis_sample_id=$crossanalysis_sample_id::INTEGER;

SELECT 
    'csv'                             AS component,
    'Télécharger les données' AS title,
    'dataset.csv'              AS filename,
    'file-download'    AS icon,
    'green'            AS color,
    ';'                AS separator,
    TRUE               AS bom;


SELECT  * FROM therm_data 
WHERE therm_dataset_id=$therm_dataset_id::INTEGER 
AND therm_data_date + therm_data_hour BETWEEN $sample_period_start::timestamp AND $sample_period_end::timestamp;
