SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

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
    'datagrid'              as component,
    'panel_therm_display' as id,
    'Bilan Therm RH' as title;

SELECT 
    '/e_project_therm/therm_set_form_4.sql?project_id='||$project_id       as link,
    'Créer une campagne de mesure'                  as description,
    'temperature-plus'                                      as icon,
    'yellow'                                         as color;

SELECT 
     '/e_project_therm/therm_set_archive_4.sql?project_id='||$project_id              as link,
    'Visualiser les mesures archivées'           as description,
    'archive'                                     as icon,
    'green'                                              as color;



SELECT 
    'table'               AS component, 
    'Liste des campagnes de mesure' AS title, 
    TRUE                  AS sort,
    JSON('{"name":"Sensor","tooltip":"Visualiser les capteurs et les données","link":"/e_project_therm/therm_set_sensor_display_4.sql?therm_set_id={id}","icon":"thermometer"}') AS custom_actions,
    '/e_project_therm/therm_set_edit_4.sql?therm_set_id={id}' as edit_url,
    '/e_project_therm/therm_set_delete_alert_4.sql?therm_set_id={id}' as delete_url,
    FALSE                 AS search;

SELECT
    t.therm_set_id            AS Id,
    t.therm_set_id            AS _sqlpage_id,
    t.therm_set_name          AS Nom,
    b.building_name           AS building,
    r.room_name               AS room
   

FROM therm_set AS t
LEFT JOIN (SELECT room_id, room_name, building_id FROM project_building_rooms) AS r 
ON r.room_id=t.room_id
LEFT JOIN (SELECT  building_id, building_name, project_id FROM project_building) AS b 
ON r.building_id=b.building_id
WHERE b.project_id = $project_id::INTEGER and therm_set_status!='archived'
ORDER BY therm_set_id ASC;


