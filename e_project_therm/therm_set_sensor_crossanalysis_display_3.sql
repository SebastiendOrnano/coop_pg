SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SET room_id = SELECT room_id FROM therm_set WHERE therm_set_id = $therm_set_id::integer;
SET building_id = SELECT building_id FROM project_building_rooms WHERE room_id = $room_id::integer;
SET project_id = SELECT project_id FROM project_building WHERE building_id = $building_id::integer;


SET therm_set_sensor_name1   = 
SELECT therm_set_sensor_name FROM therm_set_sensor AS s
LEFT JOIN (SELECT therm_set_sensor1_id, therm_set_sensor2_id, crossanalysis_id FROM therm_crossanalysis) as c
ON s.therm_set_sensor_id=c.therm_set_sensor1_id
WHERE c.crossanalysis_id=$crossanalysis_id::INTEGER

SET therm_set_sensor_name2   = 
SELECT therm_set_sensor_name FROM therm_set_sensor AS s
LEFT JOIN (SELECT therm_set_sensor1_id, therm_set_sensor2_id, crossanalysis_id FROM therm_crossanalysis) as c
ON s.therm_set_sensor_id=c.therm_set_sensor2_id
WHERE c.crossanalysis_id=$crossanalysis_id::INTEGER


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
    'datagrid'              as component,
    'panel_therm_display' as id,
    'Comparaison croisée des mésures entre 2 capteurs' as title;

SELECT 
    '/e_project_therm/therm_set_sensor_crossanalysis_step1_3.sql?therm_set_id='||$therm_set_id      as link,
    'Créer une comparaison'                        as description,
    'arrows-cross'                                           as icon,
    'blue'                                                 as color;



SELECT 
    'form' as component,
    'Rappel de la campagne' as title,
    '' as validate;

SELECT 
    'therm_set_name'   AS name,
    'text'                        AS type,
    true as readonly,
    12                            AS width,
    (SELECT therm_set_name FROM therm_set WHERE therm_set_id=$therm_set_id::INTEGER) as value,
    'Nom de la campagne'                         AS label;





SELECT 
    'table'               AS component, 
    'Liste des jeux de données' AS title, 
    TRUE                  AS sort,
    JSON('{"name":"Crossanalysis","tooltip":"Visualiser la comparaison","link":"/e_project_therm/therm_set_sensor_crossanalysis_chart_4.sql?crossanalysis_id={id}","icon":"chart-area-line"}') as custom_actions,
   JSON('{"name":"Map","tooltip":"Localisation des capteur","link":"/e_project_therm/therm_set_sensor_crossanalysis_map_3.sql?crossanalysis_id={id}","icon":"map"}') as custom_actions,
    JSON('{"name":"Archive","tooltip":"Archiver la comparaison","link":"/e_project_therm/therm_set_sensor_crossanalysis_archive_0.sql?crossanalysis_id={id}","icon":"archive"}') as custom_actions,
    TRUE                AS search;

SELECT
    d.crossanalysis_id                AS Id,
    d.crossanalysis_id                AS _sqlpage_id,
    TO_CHAR(d.crossanalysis_period_start::timestamp, 'YYYY-MM-DD HH24:MI')     AS Start, 
    TO_CHAR(d.crossanalysis_period_end::timestamp, 'YYYY-MM-DD HH24:MI')         AS End,
    (SELECT therm_set_sensor_name FROM therm_set_sensor AS s
    WHERE s.therm_set_sensor_id=d.therm_set_sensor1_id)  as Capteur1,
    (SELECT therm_set_sensor_name FROM therm_set_sensor AS s
    WHERE s.therm_set_sensor_id=d.therm_set_sensor2_id) as Capteur2
FROM therm_crossanalysis AS d

WHERE therm_set_id=$therm_set_id::INTEGER AND d.crossanalysis_status='active'
ORDER BY  d.crossanalysis_period_start ASC;
