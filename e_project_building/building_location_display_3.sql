SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_3.sql') AS properties;

SET tile_latitude = SELECT MAX(building_latitude) FROM project_building WHERE project_id=$project_id::INTEGER;
SET tile_longitude = SELECT MAX(building_longitude) FROM project_building WHERE project_id=$project_id::INTEGER;

SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion editeur'         AS title,
    '/a_panels/panel_editor_3.sql' AS link;
 SELECT 
    'Projets'            AS title,
    '/e_project/project_main_display_3.sql'     AS link;   
 SELECT 
    'Hub du projet'            AS title,
    '/e_project/project_hub_display_3.sql?project_id='||$project_id     AS link; 
SELECT 
    'Gestion des lieux'            AS title,
    '/e_project_building/building_main_display_3.sql?project_id='||$project_id     AS link;


SELECT 
    'map'   AS component,
    'Carte de nos projets' AS title,
    7   AS zoom,
    $tile_latitude  AS latitude,
    $tile_longitude  AS longitude,
    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png' AS tile_source;

SELECT 
    building_name               AS title,
    'indigo'                    AS color,
    'map-pin'                   AS icon,
    'http://localhost:8080/e_project_building/building_main_profile_4.sql?building_id='||building_id AS link,
     building_latitude::FLOAT           AS latitude,
     building_longitude::FLOAT         AS longitude
     FROM project_building
      WHERE project_id=$project_id::INTEGER;




