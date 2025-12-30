SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_3.sql') AS properties;

SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion éditeur'         AS title,
    '/a_panels/panel_editor_3.sql' AS link;
SELECT 
    'Projets'            AS title,
    '/e_project/project_main_display_3.sql'      AS link;



SET max_latitude = SELECT MAX(building_latitude)  FROM project_building WHERE building_name IS NOT NULL;
SET max_longitude = SELECT MAX(building_longitude)  FROM project_building WHERE building_name IS NOT NULL;

SELECT 
    'map'   AS component,
    'Carte de nos projets' AS title,
    11   AS zoom,
    $max_latitude AS latitude,
    $max_longitude  AS longitude,
    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png' AS tile_source;

SELECT 
    building_name             AS title,
    'indigo'                    AS color,
    'map-pin'                   AS icon,
    '/e_project_building/building_main_profile_4.sql?building_id='||building_id AS link,
     building_latitude           AS latitude,
     building_longitude         AS longitude
     FROM project_building
     WHERE building_name IS NOT NULL;
    




