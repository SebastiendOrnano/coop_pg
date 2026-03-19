SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;


SET therm_set_id = SELECT therm_set_id FROM therm_crossanalysis WHERE crossanalysis_id=$crossanalysis_id::INTEGER;
SET room_id = SELECT room_id FROM therm_set WHERE therm_set_id = $therm_set_id::integer;
SET building_id = SELECT building_id FROM project_building_rooms WHERE room_id = $room_id::integer;
SET project_id = SELECT project_id FROM project_building WHERE building_id = $building_id::integer;

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
    'Therm'            as title,
    '/e_project_therm/therm_set_display_4.sql?project_id='||$project_id     as link;   
 SELECT 
    'Capteur'            as title,
    '/e_project_therm/therm_set_sensor_display_4.sql?therm_set_id='||$therm_set_id     as link;   
 SELECT 
    'Comparaisons'            as title,
    '/e_project_therm/therm_set_sensor_crossanalysis_display_4.sql?therm_set_id='||$therm_set_id     as link;   


SELECT 
    'datagrid'              as component,
    'panel_therm_display' as id,
    'Comparaison croisée des mésures entre 2 capteurs' as title;

SELECT 
    '/e_project_therm/therm_set_sensor_crossanalysis_step1_4.sql?therm_set_id='||$therm_set_id      as link,
    'Créer une comparaison'                        as description,
    'arrows-cross'                                           as icon,
    'blue'                                                 as color;

SELECT 
     '/e_project_therm/therm_set_sensor_crossanalysis_archive_4.sql?therm_set_id='||$therm_set_id      as link,
    'Visualiser les comparaisons archivées'           as description,
    'archive'                                     as icon,
    'green'                                              as color;


SELECT 
    'form' as component,
    '' as validate;

SELECT 
    'therm_set_name'   AS name,
    'text'                        AS type,
    true as readonly,
    12                            AS width,
    (SELECT therm_set_name FROM therm_set WHERE therm_set_id=$therm_set_id::INTEGER) as value,
    'Nom de la campagne'                         AS label;

SELECT 
    'map'   AS component,
    'Localisation des capteurs' AS title,
    16 AS zoom,
    'https://{s}.tile.openstreetmap.fr/osmfr/{z}/{x}/{y}.png' AS tile_source;
SELECT 
    t.therm_set_sensor_name      AS title,
    ST_AsGeoJSON(t.therm_set_sensor_point)  AS geojson
    FROM therm_set_sensor AS t
    LEFT JOIN (SELECT therm_set_sensor1_id, crossanalysis_id FROM therm_crossanalysis) AS s
    ON t.therm_set_sensor_id=s.therm_set_sensor1_id
    WHERE s.crossanalysis_id=$crossanalysis_id::integer;

SELECT 
    t.therm_set_sensor_name      AS title,
    ST_AsGeoJSON(t.therm_set_sensor_point)  AS geojson
    FROM therm_set_sensor AS t
    LEFT JOIN (SELECT therm_set_sensor2_id, crossanalysis_id FROM therm_crossanalysis) AS s
    ON t.therm_set_sensor_id=s.therm_set_sensor2_id
    WHERE crossanalysis_id=$crossanalysis_id::integer;