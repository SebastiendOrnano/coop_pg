SET therm_set_id = SELECT therm_set_id FROM therm_crossanalysis WHERE crossanalysis_id=$crossanalysis_id::INTEGER;
SET room_id = (SELECT room_id FROM therm_set WHERE therm_set_id = $therm_set_id::integer);
SET building_id = (SELECT building_id  FROM project_building_rooms  WHERE room_id = $room_id::integer);
SET project_id = (SELECT project_id  FROM project_building  WHERE building_id = $building_id::integer);



SET datasetsensor1 = SELECT datasetsensor1 FROM therm_crossanalysis WHERE crossanalysis_id=$crossanalysis_id::INTEGER;
SET datasetsensor2 = SELECT datasetsensor2 FROM therm_crossanalysis WHERE crossanalysis_id=$crossanalysis_id::INTEGER;
SET crossanalysis_period_start = SELECT crossanalysis_period_start FROM therm_crossanalysis WHERE crossanalysis_id=$crossanalysis_id::INTEGER;
SET crossanalysis_period_end = SELECT crossanalysis_period_end FROM therm_crossanalysis WHERE crossanalysis_id=$crossanalysis_id::INTEGER;

SET therm_dataset_id =
SELECT 
CASE 
WHEN $datasetsensor::text = '1' THEN $datasetsensor1
ELSE $datasetsensor2
END;


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
AND therm_data_date + therm_data_hour BETWEEN $crossanalysis_period_start::timestamp AND $crossanalysis_period_end::timestamp;
