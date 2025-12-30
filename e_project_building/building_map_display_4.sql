SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SET project_id = SELECT project_id FROM project_building WHERE building_id=$building_id::INTEGER;
SET tile_latitude = SELECT MAX(building_latitude) FROM project_building WHERE project_id=$project_id::INTEGER;
SET tile_longitude = SELECT MAX(building_longitude) FROM project_building WHERE project_id=$project_id::INTEGER;



SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion Superviseur'         AS title,
    '/a_panels/panel_supervisor_4.sql' AS link;
 SELECT 
    'Retour à la liste des projets'            AS title,
    '/e_project/project_main_display_4.sql'     AS link;   
 SELECT 
    'Retour au hub du projet'            AS title,
    '/e_project/project_hub_display_4.sql?project_id='||$project_id     AS link;
SELECT 
    'Gestion des bâtiments'            AS title,
    '/e_project_building/building_main_display_4.sql?project_id='||$project_id     AS link;

SELECT 
    'map'   AS component,
    'Carte de nos projets' AS title,
    11   AS zoom,

    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png' AS tile_source;

SELECT 
    building_name               AS title,
    'indigo'                    AS color,
    'map-pin'                   AS icon,
    'http://localhost:8080/e_project_building/building_main_profile_4.sql?building_id='||building_id AS link,
     building_latitude           AS latitude,
     building_longitude         AS longitude
     FROM project_building
  WHERE building_id=$building_id::INTEGER;
    




