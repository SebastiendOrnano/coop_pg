SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_3.sql') AS properties;

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
    'datagrid'              as component,
    'panel_therm_display' as id,
    'Bilan Therm RH' as title;

SELECT 
    '/e_project_therm/therm_sensor_form_3.sql'      as link,
    'Créer un capteur'                  as description,
    'temperature-plus'                                      as icon,
    'yellow'                                         as color;


SELECT 
    'table'               AS component, 
    'Liste des capteurs'  AS title, 
    TRUE                  AS sort, 
    '/e_project_therm/therm_sensor_edit_3.sql?therm_sensor_id={id}' as edit_url,
    FALSE                 AS search;

SELECT
    therm_sensor_id            AS Id,
    therm_sensor_id            AS _sqlpage_id,
    therm_sensor_name          AS Nom
FROM therm_sensor
WHERE therm_sensor_status!='archived'
ORDER BY therm_sensor_id ASC;


