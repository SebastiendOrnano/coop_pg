SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;


SET therm_set_id = SELECT therm_set_id FROM therm_set_sensor WHERE therm_set_sensor_id = $therm_set_sensor_id::INTEGER;
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
    'Capteur'            as title,
    '/e_project_therm/therm_set_sensor_display_4.sql?therm_set_id='||$therm_set_id     as link;   
SELECT 
    'Dataset actifs'            as title,
    '/e_project_therm/therm_dataset_display_4.sql?therm_set_sensor_id='||$therm_set_sensor_id as link;

SELECT 
    'table'               AS component, 
    'Liste des jeux de données' AS title, 
    TRUE                  AS sort,
    '/e_project_therm/therm_dataset_edit_4.sql?therm_dataset_id={id}' as edit_url,
    '/e_project_therm/therm_dataset_delete_alert_4.sql?therm_dataset_id={id}' as delete_url,
    FALSE                 AS search;

SELECT
    d.therm_dataset_id            AS Id,
    d.therm_dataset_id            AS _sqlpage_id,
    d.therm_dataset_name          AS nom,
    CASE
    WHEN EXISTS (SELECT 1 FROM therm_data WHERE  therm_dataset_id=d.therm_dataset_id::INTEGER)
    THEN JSON('{"name":"Purge","tooltip":"Vider les données","link":"/e_project_therm/therm_data_purge_alert_4.sql?therm_dataset_id={id}","icon":"trash"}')
    ELSE JSON('{"name":"Purge"}') 
    END AS _sqlpage_actions,

    CASE    
    WHEN EXISTS (SELECT 1 FROM therm_data WHERE  therm_dataset_id=d.therm_dataset_id::INTEGER)
    THEN JSON('{"name":"View","tooltip":"lire les données","link":"/e_project_therm/therm_data_display_4.sql?therm_dataset_id={id}","icon":"table-share"}') 
    ELSE JSON('{"name":"View"}') 
    END AS _sqlpage_actions,

    CASE 
    WHEN EXISTS (SELECT 1 FROM therm_data WHERE  therm_dataset_id=d.therm_dataset_id::INTEGER)
    THEN JSON('{"name":"Chart","tooltip":"graphique","link":"/e_project_therm/therm_dataset_chart_4.sql?therm_dataset_id={id}","icon":"chart-line"}') 
    ELSE JSON('{"name":"Chart"}') 
    END AS _sqlpage_actions,

   MIN(a.therm_data_date + a.therm_data_hour)           AS Start,
   MAX(a.therm_data_date + a.therm_data_hour)           AS End
FROM therm_dataset AS d
LEFT JOIN (SELECT therm_dataset_id, therm_data_date, therm_data_hour FROM therm_data) AS a 
ON a.therm_dataset_id=d.therm_dataset_id
WHERE d.therm_set_sensor_id=$therm_set_sensor_id::INTEGER AND d.therm_dataset_status='archived'
GROUP BY d.therm_dataset_id ;


