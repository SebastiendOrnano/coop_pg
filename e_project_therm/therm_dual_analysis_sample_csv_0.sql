SET dual_analysis_id = SELECT dual_analysis_id FROM therm_dual_analysis_sample WHERE dual_analysis_sample_id=$dual_analysis_sample_id::INTEGER;


SET therm_dataset_id = 
CASE 
WHEN $dataset='1' THEN (SELECT dataset1_id FROM therm_dual_analysis WHERE dual_analysis_id=$dual_analysis_id::INTEGER)
ELSE (SELECT dataset2_id FROM therm_dual_analysis WHERE dual_analysis_id=$dual_analysis_id::INTEGER)
END;

SET period_start1 = SELECT dataset1_sample_date_start+dataset1_sample_hour_start FROM therm_dual_analysis_sample WHERE dual_analysis_sample_id=$dual_analysis_sample_id::INTEGER;
SET period_end1 = SELECT dataset1_sample_date_end+dataset1_sample_hour_end FROM therm_dual_analysis_sample WHERE dual_analysis_sample_id=$dual_analysis_sample_id::INTEGER;

SET period_start2 = SELECT dataset2_sample_date_start+dataset2_sample_hour_start FROM therm_dual_analysis_sample WHERE dual_analysis_sample_id=$dual_analysis_sample_id::INTEGER;
SET period_end2 = SELECT dataset2_sample_date_end+dataset2_sample_hour_end FROM therm_dual_analysis_sample WHERE dual_analysis_sample_id=$dual_analysis_sample_id::INTEGER;

SET period_start =
CASE 
WHEN $dataset='1' 
THEN $period_start1
ELSE $period_start2
END;

SET period_end =
CASE 
WHEN $dataset='1' 
THEN $period_end1
ELSE $period_end2
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
AND therm_data_date + therm_data_hour BETWEEN $period_start::timestamp AND $period_end::timestamp;
