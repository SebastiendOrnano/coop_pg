SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_3.sql') AS properties;


SET therm_set_id = SELECT therm_set_id FROM therm_set_sensor WHERE therm_set_sensor_id = $therm_set_sensor_id::INTEGER;
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
    'Capteurs'            as title,
    '/e_project_therm/therm_set_sensor_display_3.sql?therm_set_id='||$therm_set_id     as link;    


SELECT 
    'form' as component,
    'Actualiser un capteur' as title,
    'Actualiser' as validate,
    'Clear' as reset,
    '/e_project_therm/therm_set_sensor_update_0.sql?therm_set_sensor_id='||$therm_set_sensor_id as action;

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
    FROM project_building_rooms AS r
    LEFT JOIN (SELECT room_id, therm_set_id FROM therm_set) AS s
    ON r.room_id=s.room_id
    WHERE s.therm_set_id=$therm_set_id::INTEGER ) as value;

SELECT 
    'therm_sensor_id' AS name,
    'Capteur' AS label,
    'select' AS type,
    6 AS width,
    TRUE AS searchable,
    (SELECT therm_sensor_name FROM therm_sensor AS t
    LEFT JOIN (SELECT therm_sensor_id, therm_set_sensor_id FROM therm_set_sensor) AS s
    ON t.therm_sensor_id=s.therm_sensor_id
    WHERE s.therm_set_sensor_id=$therm_set_sensor_id::INTEGER ) as value,

    json_agg(JSON_BUILD_OBJECT('label',therm_sensor_name||' -- '||therm_sensor_model||' -- '||therm_sensor_serie_no , 'value', therm_sensor_id))  AS options
    FROM therm_sensor;

SELECT 
    'therm_set_sensor_point'        AS name,
    'file'                            AS type,
    6 AS width,
    'application/geo+json'            AS accept,
    'Localisation capteur'          AS label,
    'Upload coordo of a point (geojson file)'    AS description;

SELECT 
    'therm_set_sensor_status'            as name,
    'Statut'                 as label,
    'select'                 as type,
    3 as width,
    TRUE                     as required,
    (SELECT therm_set_status  FROM therm_set WHERE therm_set_id = $therm_set_id::INTEGER ) as value,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='status';

SELECT 
    'therm_set_sensor_description'        AS name,
    'text'                            AS type,
    6 AS width,
    (SELECT therm_set_sensor_description FROM therm_set_sensor WHERE therm_set_sensor_id=$therm_set_sensor_id::INTEGER) as value,
    'Commentaires'          AS label;

