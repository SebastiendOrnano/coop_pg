SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

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
    'Projets'            as title,
    '/e_project/project_main_display_4.sql'     as link;   
 SELECT 
    'Hub du projet'            as title,
    '/e_project/project_hub_display_4.sql?project_id='||$project_id     as link;   
SELECT 
    'Campagnes mesure'            as title,
    '/e_project_therm/therm_set_display_4.sql?project_id='||$project_id     as link;
 SELECT 
    'Comparaisons'            as title,
    '/e_project_therm/therm_set_sensor_crossanalysis_display_4.sql?therm_set_id='||$therm_set_id     as link;   

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
    'table'               AS component, 
    'Liste des jeux de données' AS title, 
    TRUE                  AS sort,
    JSON('{"name":"Crossanalysis","tooltip":"Visualiser la comparaison","link":"/e_project_therm/therm_set_sensor_crossanalysis_chart_4.sql?crossanalysis_id={id}","icon":"chart-area-line"}') as custom_actions,
    JSON('{"name":"Unarchive","tooltip":"Archiver la comparaison","link":"/e_project_therm/therm_set_sensor_crossanalysis_unarchive_0.sql?crossanalysis_id={id}","icon":"archive-off"}') as custom_actions,
    '/e_project_therm/therm_set_sensor_crossanalysis_delete_alert_4.sql?crossanalysis_id={id}' as delete_url,
    FALSE                 AS search;

SELECT
    d.crossanalysis_id                AS Id,
    d.crossanalysis_id                AS _sqlpage_id,
    TO_CHAR(d.crossanalysis_period_start::timestamp, 'YYYY-MM-DD HH24:MI')     AS Start, 
    TO_CHAR(d.crossanalysis_period_end::timestamp, 'YYYY-MM-DD HH24:MI')         AS End,
    (SELECT therm_set_sensor_name FROM therm_set_sensor AS s
    WHERE s.therm_set_sensor_id=d.datasetsensor1)  as Capteur1,
    (SELECT therm_set_sensor_name FROM therm_set_sensor AS s
    WHERE s.therm_set_sensor_id=d.datasetsensor2) as Capteur2

WHERE therm_set_id=$therm_set_id::INTEGER AND d.crossanalysis_status !='active'
ORDER BY  d.crossanalysis_period_start ASC;
