SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_3.sql') AS properties;

SET dual_analysis_id = SELECT dual_analysis_id FROM therm_dual_analysis_sample WHERE dual_analysis_sample_id=$dual_analysis_sample_id::INTEGER;
SET therm_set_sensor_id = SELECT therm_set_sensor_id FROM therm_dual_analysis WHERE dual_analysis_id=$dual_analysis_id::INTEGER;
SET therm_set_id = SELECT therm_set_id FROM therm_set_sensor WHERE therm_set_sensor_id=$therm_set_sensor_id::INTEGER;
SET room_id = SELECT room_id FROM therm_set WHERE therm_set_id = $therm_set_id::integer;
SET building_id = SELECT building_id FROM project_building_rooms WHERE room_id = $room_id::integer;
SET project_id = SELECT project_id FROM project_building WHERE building_id = $building_id::integer;



SELECT 
    'breadcrumb' as component;
SELECT 
    'Home' as title,
    '/'    as link;
SELECT 
    'Gestion editeur'         as title,
    '/a_panels/panel_editor_3.sql' as link;
 SELECT 
    'liste des projets'            as title,
    '/e_project/project_main_display_3.sql'     as link;   
 SELECT 
    'hub du projet'            as title,
    '/e_project/project_hub_display_3.sql?project_id='||$project_id     as link;   
 SELECT 
    'Therm'            as title,
    '/e_project_therm/therm_set_display_3.sql?project_id='||$project_id     as link;   
 SELECT 
    'Capteur'            as title,
    '/e_project_therm/therm_set_sensor_display_3.sql?therm_set_id='||$therm_set_id     as link;   
 SELECT 
    'Dataset'            as title,
    '/e_project_therm/therm_dataset_display_3.sql?therm_set_sensor_id='||$therm_set_sensor_id    as link; 


SELECT 
    'form' as component,
    'Cadre général des mesures' as title,
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
    WHERE t.therm_set_sensor_id = $therm_set_sensor_id::INTEGER
    ) AS value,
    4 AS width;


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
    WHERE t.therm_set_sensor_id = $therm_set_sensor_id::INTEGER
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
    WHERE t.therm_set_sensor_id = $therm_set_sensor_id::INTEGER
    ) AS value,
    2 AS width;

SELECT
    'therm_sensor_name' as name,
    'text' as type,  
    'Capteur' as label,
    true as readonly,
    (SELECT therm_sensor_name FROM therm_sensor AS s
    LEFT JOIN (SELECT therm_set_id, therm_sensor_id, therm_set_sensor_id FROM therm_set_sensor) AS t
    ON s.therm_sensor_id = t.therm_sensor_id 

    WHERE t.therm_set_sensor_id = $therm_set_sensor_id::INTEGER
    ) AS value,
    2 AS width;

SELECT 
    'text' as component,
    TRUE as center,
    'Comparaison entre 2 jeux de données (même capteur) après un échantillonnage'  as title;



SELECT  
    'card' as component,
    2      as columns;
SELECT 
    '/e_project_therm/therm_dual_analysis_sample_chart_step2_4.sql?dual_analysis_sample_id='||$dual_analysis_sample_id||'&dataset=1&_sqlpage_embed' as embed;
SELECT 
    '/e_project_therm/therm_dual_analysis_sample_chart_step2_4.sql?dual_analysis_sample_id='||$dual_analysis_sample_id||'&dataset=2&_sqlpage_embed'  as embed;
