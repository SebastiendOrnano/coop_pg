SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SET room_id = SELECT  room_id FROM therm_set WHERE therm_set_id=$therm_set_id::INTEGER;
SET building_id = SELECT  building_id FROM project_building_rooms WHERE room_id=$room_id::INTEGER;
SET project_id = SELECT  project_id FROM project_building WHERE building_id=$building_id::INTEGER;


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
    'Campagne'            as title,
    '/e_project_therm/therm_set_display_4.sql?project_id='||$project_id     as link;    
 SELECT 
    'Capteurs'            as title,
    '/e_project_therm/therm_set_sensor_display_4.sql?therm_set_id='||$therm_set_id     as link;    


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
    '/e_project_therm/therm_set_sensor_delete_alert_4.sql?therm_set_sensor_id={id}' as delete_url,
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
LEFT JOIN (SELECT therm_sensor_id, therm_sensor_name  FROM therm_sensor) as t
ON d.therm_sensor_id = t.therm_sensor_id
LEFT JOIN (SELECT room_id, room_name, building_id FROM project_building_rooms) AS r 
ON r.room_id=s.room_id
LEFT JOIN (SELECT  building_id, project_id FROM project_building) AS b 
ON r.building_id=b.building_id
WHERE d.therm_set_id= $therm_set_id::INTEGER AND d.therm_set_sensor_status='archived'
ORDER BY d.therm_set_sensor_id ASC;
