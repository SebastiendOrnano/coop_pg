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
    'Sensor'            as title,
    '/e_project_therm/therm_sensor_display_4.sql'   as link;  



SELECT 
    'table'               AS component, 
    'Liste des sondes de mesure' AS title, 
    TRUE                  AS sort, 
    '/e_project_therm/therm_sensor_edit_4.sql?therm_sensor_id={id}' as edit_url,
    '/e_project_therm/therm__sensor_alert_4.sql?therm_sensor_id={id}' as delete_url,
    FALSE                 AS search;

SELECT
    therm_sensor_id            AS Id,
    therm_sensor_id            AS _sqlpage_id,
    therm_sensor_name          AS Nom
FROM therm_sensor
WHERE therm_sensor_status='archived'
ORDER BY therm_sensor_id ASC;


