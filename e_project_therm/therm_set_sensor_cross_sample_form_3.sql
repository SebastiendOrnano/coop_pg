SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_3.sql') AS properties;

SET therm_set_id = SELECT therm_set_id FROM therm_crossanalysis WHERE crossanalysis_id=$crossanalysis_id::INTEGER;
SET room_id = (SELECT room_id FROM therm_set WHERE therm_set_id = $therm_set_id::integer);
SET building_id = (SELECT building_id  FROM project_building_rooms  WHERE room_id = $room_id::integer);
SET project_id = (SELECT project_id  FROM project_building  WHERE building_id = $building_id::integer);

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
SELECT 
    'periode complète'            as title,
    '/e_project_therm/therm_set_sensor_crossanalysis_chart_3.sql?therm_set_id='||$therm_set_id||'&crossanalysis_id='||$crossanalysis_id   as link;


SET datasetsensor1 = (SELECT datasetsensor1 FROM therm_crossanalysis WHERE crossanalysis_id=$crossanalysis_id::INTEGER);
SET datasetsensor2 = (SELECT datasetsensor2 FROM therm_crossanalysis WHERE crossanalysis_id=$crossanalysis_id::INTEGER);

SET date_start_min = (SELECT DATE(crossanalysis_period_start) FROM therm_crossanalysis WHERE crossanalysis_id=$crossanalysis_id::INTEGER LIMIT 1);
SET date_end_max = (SELECT DATE(crossanalysis_period_end) FROM therm_crossanalysis WHERE crossanalysis_id=$crossanalysis_id::INTEGER LIMIT 1);
SET hour_start_min = (SELECT TO_CHAR(crossanalysis_period_start, 'HH24:MI') FROM therm_crossanalysis WHERE crossanalysis_id=$crossanalysis_id::INTEGER  LIMIT 1);
SET hour_end_max = (SELECT TO_CHAR(crossanalysis_period_end, 'HH24:MI') FROM therm_crossanalysis WHERE crossanalysis_id=$crossanalysis_id::INTEGER  LIMIT 1);

SELECT 
    'form' as component,
    'Plage de temps commune pour les deux capteurs' as title,
    '' as validate;

SELECT
    'date_start_min' as name,
    'text' as type,  
    'Date début des enregistrements' as label,
    3 AS width,
    $date_start_min::DATE as value,
    TRUE as readonly;
SELECT
    'hour_start_min' as name,
    'text' as type,  
    'Heure début des enregistrements' as label,
    3 AS width,
    $hour_start_min::TIME as value,
    TRUE as readonly;
SELECT
    'date_end_max' as name,
    'text' as type,  
    'Date fin des enregistrements' as label,
    3 AS width,
    $date_end_max::DATE as value,
    TRUE as readonly;
SELECT
    'hour_end_max' as name,
    'text' as type,  
    'Heure fin des enregistrements' as label,
    3 AS width,
    $hour_end_max::TIME as value,
    TRUE as readonly;


SELECT 
    'form' as component,
    'Choisir une échantillon sur la plage de temps commune' as title,
    'Créer' as validate,
    'Clear' as reset,
    '/e_project_therm/therm_set_sensor_cross_sample_create_0.sql?crossanalysis_id='||$crossanalysis_id as action;
SELECT
    'datasetsensor1' as name,
    'hidden'      as type,
    $datasetsensor1::INTEGER AS value;
SELECT
    'datasetsensor2' as name,
    'hidden'      as type,
    $datasetsensor2::INTEGER  AS value;
SELECT
    'crossanalysis_id' as name,
    'hidden'      as type,
    $crossanalysis_id::INTEGER  AS value;
SELECT 
    'date_start_min' as name, 
    'hidden'      as type,
    $date_start_min::date AS value;
SELECT 
    'date_end_max' as name, 
    'hidden'      as type,
    $date_end_max::date  AS value;
SELECT 
    'hour_start_min' as name, 
    'hidden'      as type,
    $hour_start_min::time  AS value;
SELECT 
    'hour_end_max' as name, 
    'hidden'      as type,
    $hour_end_max::time  AS value;
SELECT
    'crossanalysis_period_start' as name,
    'hidden'      as type,
    (SELECT crossanalysis_period_start FROM therm_crossanalysis WHERE crossanalysis_id=$crossanalysis_id::INTEGER) AS value;
SELECT
    'crossanalysis_period_end' as name,
    'hidden'      as type,
    (SELECT crossanalysis_period_end FROM therm_crossanalysis WHERE crossanalysis_id=$crossanalysis_id::INTEGER) AS value;
SELECT
    'crossanalysis_sample_date_start'                 as name,
    'Jour début analyse'          as label,
    'select'                                as type,
    3                                      AS width,
    'Choisir une date dans la liste...'    AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label', date_jour, 'value', date_jour)) AS options
FROM (
    SELECT generate_series(
        DATE(crossanalysis_period_start), 
        DATE(crossanalysis_period_end), 
        INTERVAL '1 day'
    )::date AS date_jour
    FROM therm_crossanalysis 
    WHERE crossanalysis_id=$crossanalysis_id::INTEGER
    ORDER BY date_jour
) AS dates;

SELECT 
    'crossanalysis_sample_hour_start' AS name,
    'Heure début analyse'       AS label,
    'select'                      AS type,
    3                            AS width,
    'Choisir une heure dans la liste...'    AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label', i.choice_label, 'value', i.choice_value) ORDER BY i.choice_value) AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='list_hours' ;
SELECT
    'crossanalysis_sample_date_end'                 as name,
    'Date fin analyse'          as label,
    'select'                                as type,
    3                                      AS width,
    'Choisir une date dans la liste...'    AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label', date_jour, 'value', date_jour)) AS options
FROM (
    SELECT generate_series(
        DATE(crossanalysis_period_start), 
        DATE(crossanalysis_period_end), 
        INTERVAL '1 day'
    )::date AS date_jour
    FROM therm_crossanalysis 
   WHERE crossanalysis_id=$crossanalysis_id::INTEGER
    ORDER BY date_jour
) AS dates;

SELECT 
    'crossanalysis_sample_hour_end' AS name,
    'Heure fin analyse équence'       AS label,
    'select'                      AS type,
    3                            AS width,
    'Choisir une heure dans la liste...'    AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label', i.choice_label, 'value', i.choice_value) ORDER BY i.choice_value) AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='list_hours' ;

