SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_3.sql') AS properties;

SET room_id = SELECT room_id FROM therm_set WHERE therm_set_id = $therm_set_id::integer;
SET building_id = SELECT building_id FROM project_building_rooms WHERE room_id = $room_id::integer;
SET project_id = SELECT project_id FROM project_building WHERE building_id = $building_id::integer;

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
    'Gestion des capteurs pour une campagne de mesure' as title;
SELECT 
    '/e_project_therm/therm_set_sensor_form_3.sql?therm_set_id='||$therm_set_id      as link,
    'Positionner un capteur'                                as description,
    'temperature-plus'                                      as icon,
    'yellow'                                                 as color;

SELECT 
    '/e_project_therm/therm_set_sensor_crossanalysis_step1_3.sql?therm_set_id='||$therm_set_id      as link,
    'Comparer les mesures 2 capteurs'                        as description,
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
    JSON('{"name":"Dataset","tooltip":"Gérer les données du capteur","link":"/e_project_therm/therm_dataset_display_4.sql?therm_set_sensor_id={id}","icon":"table-share"}') as custom_actions,
   '/e_project_therm/therm_set_sensor_edit_4.sql?therm_set_sensor_id={id}' as edit_url,
    FALSE                 AS search;

SELECT
    d.therm_set_sensor_id        AS Id,
    d.therm_set_sensor_id        AS _sqlpage_id,
    r.room_name                      AS Lieu,
    t.therm_sensor_name      AS Nom,
    CASE
    WHEN d.therm_set_sensor_point IS NOT NULL
    THEN JSON('{"name":"Map","tooltip":"Localisation du capteur","link":"/e_project_therm/therm_set_sensor_map_4.sql?therm_set_sensor_id={id}","icon":"map"}')
    ELSE JSON('{"name":"Map"}')
    END  as _sqlpage_actions
FROM therm_set_sensor AS d
LEFT JOIN (SELECT therm_set_id, therm_set_name, room_id FROM therm_set) AS s 
ON s.therm_set_id=d.therm_set_id
LEFT JOIN (SELECT therm_sensor_id, therm_sensor_name FROM therm_sensor) as t
ON d.therm_sensor_id = t.therm_sensor_id
LEFT JOIN (SELECT room_id, room_name, building_id FROM project_building_rooms) AS r 
ON r.room_id=s.room_id
LEFT JOIN (SELECT  building_id, project_id FROM project_building) AS b 
ON r.building_id=b.building_id
WHERE d.therm_set_id= $therm_set_id::INTEGER AND d.therm_set_sensor_status!='archived'
ORDER BY d.therm_set_sensor_id ASC;
