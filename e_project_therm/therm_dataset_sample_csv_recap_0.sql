-- 1. Composant CSV
SELECT 
    'csv' AS component,
    'Récap Mesures' AS title,
    'recap_mesures.csv' AS filename,
    'file-download' AS icon,
    'blue' AS color,
    '"' AS quote,     -- ✅ GUILLEMETS obligatoires
    ';' AS separator,
    TRUE AS bom;

-- 2. NOMS DE COLONNES (15 colonnes exactement)
SELECT 
    '"Contexte"' AS contexte,
    '"Dataset_ID"' AS dataset_id,
    '"Dataset_Name"' AS dataset_name,
    '"Capteur"' AS capteur_nom,
    '"Temp_Max_C"' AS temp_max,
    '"Temp_Min_C"' AS temp_min,
    '"Temp_Moy_C"' AS temp_moy,
    '"RH_Max"' AS rh_max,
    '"RH_Min"' AS rh_min,
    '"RH_Moy"' AS rh_moy,
    '"CO2_Max_ppm"' AS co2_max,
    '"CO2_Min_ppm"' AS co2_min,
    '"CO2_Moy_ppm"' AS co2_moy,
    '"Nb_Points"' AS nb_points,
    '"Intervalle_Mn"' AS intervalle_moyen_mn;

-- 3. UNE LIGNE avec TOUS les calculs (15 colonnes exactement)
SELECT 
    '"Récap Mesures"' AS contexte,
    $therm_dataset_id::INTEGER::TEXT AS dataset_id,
    
    '"' || (SELECT therm_dataset_name FROM therm_dataset WHERE therm_dataset_id = $therm_dataset_id::INTEGER) || '"' AS dataset_name,
    
    '"' || (SELECT s.therm_sensor_name 
     FROM therm_sensor s 
     JOIN therm_set_sensor t ON s.therm_sensor_id = t.therm_sensor_id 
     JOIN therm_dataset d ON d.therm_set_sensor_id = t.therm_set_sensor_id 
     WHERE d.therm_dataset_id = $therm_dataset_id::INTEGER) || '"' AS capteur_nom,
    
    ROUND(COALESCE(MAX(therm_data_temp), 0), 2)::TEXT AS temp_max,
    ROUND(COALESCE(MIN(therm_data_temp), 0), 2)::TEXT AS temp_min,
    ROUND(AVG(therm_data_temp), 2)::TEXT AS temp_moy,
    
    ROUND(COALESCE(MAX(therm_data_rh), 0), 2)::TEXT AS rh_max,
    ROUND(COALESCE(MIN(therm_data_rh), 0), 2)::TEXT AS rh_min,
    ROUND(AVG(therm_data_rh), 2)::TEXT AS rh_moy,
    
    COALESCE(MAX(therm_data_co2), 0)::TEXT AS co2_max,
    COALESCE(MIN(therm_data_co2), 0)::TEXT AS co2_min,
    ROUND(COALESCE(AVG(therm_data_co2), 0), 0)::TEXT AS co2_moy,
    
    COUNT(*)::TEXT AS nb_points,
    
    (SELECT ROUND(AVG(diff_minutes), 1)::TEXT
     FROM (
         SELECT 
             EXTRACT(EPOCH FROM (
                 (therm_data_date + therm_data_hour) - 
                 LAG(therm_data_date + therm_data_hour) OVER (ORDER BY therm_data_date + therm_data_hour)
             )) / 60 AS diff_minutes
         FROM therm_data 
         WHERE therm_dataset_id = $therm_dataset_id::INTEGER
     ) t
     WHERE diff_minutes IS NOT NULL
    ) AS intervalle_moyen_mn

FROM therm_data 
WHERE therm_dataset_id = $therm_dataset_id::INTEGER
AND therm_data_date + therm_data_hour BETWEEN $period_start::timestamp AND $period_end::timestamp;
