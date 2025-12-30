SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion Superviseur'         AS title,
    '/a_panels/panel_supervisor_4.sql' AS link;
SELECT 
    'Retour aux project actifs'         AS title,
    '/e_project/project_main_display_4.sql'             AS link;



SET max_latitude = SELECT MAX(building_latitude)  FROM project_building WHERE project_id=$project_id::INTEGER;
SET max_longitude = SELECT MAX(building_longitude)  FROM project_building WHERE project_id=$project_id::INTEGER;

SELECT 
    'map'   AS component,
    'Carte de nos projets' AS title,
    8   AS zoom,
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
    




