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
    'Capteurs'            as title,
    '/e_project_therm/therm_set_sensor_display_4.sql?therm_set_id='||$therm_set_id     as link;   

SELECT 
    'form' as component,
    'Définir un capteur' as title,
    'Créer' as validate,
    'Clear' as reset,
    '/e_project_therm/therm_set_sensor_create_0.sql?therm_set_id='||$therm_set_id as action;

SELECT
    'therm_set_name' as name,
    true  AS readonly, 
    'Nom' as label,
    6 AS width,
    (SELECT therm_set_name FROM therm_set WHERE therm_set_id=$therm_set_id::INTEGER) as value;

SELECT 
    'room_name' AS name,
    'lieu' AS label,
    true  AS readonly, 
    6 AS width, 
    (SELECT room_name 
    FROM therm_set as s 
    LEFT JOIN (SELECT room_id, room_name, building_id FROM project_building_rooms)  AS r
    ON s.room_id = r.room_id 
    LEFT JOIN (SELECT building_id, building_name, project_id FROM project_building)  AS b 
    ON r.building_id = b.building_id
    WHERE s.therm_set_id=$therm_set_id::INTEGER) as value;

SELECT 
    'therm_sensor_id'             AS name,
    'Capteur'                     AS label,
    'select'                      AS type,
    4                             AS width,
    TRUE                          AS searchable,
   'Saisissez quelques lettres du titre que vous cherchez ou choississez dans la liste' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',therm_sensor_name||' -- '||therm_sensor_model||' -- '||therm_sensor_serie_no , 'value', therm_sensor_id))  AS options
    FROM therm_sensor;

SELECT 
    'therm_set_sensor_point'          AS name,
    'file'                            AS type,
    4                                 AS width,
    'application/geo+json'            AS accept,
    'Localisation capteur'            AS label,
    'Upload coordo of a point (geojson file)'    AS description;

SELECT 
    'therm_set_sensor_description'        AS name,
    'text'                                AS type,
    6                                     AS width,
    'Commentaires'                        AS label,
    'note sur le positionnement du capteur...'      as description;