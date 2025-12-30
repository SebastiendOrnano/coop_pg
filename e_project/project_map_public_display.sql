SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell.sql') AS properties;


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
     building_latitude           AS latitude,
     building_longitude         AS longitude
     FROM project_building
     WHERE building_name IS NOT NULL;