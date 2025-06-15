SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_3.sql') AS properties;

SET tile_latitude = SELECT MAX(project_meeting_place_latitude) FROM project_meeting_places;
SET tile_longitude = SELECT MAX(project_meeting_place_longitude) FROM project_meeting_places;

SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion éditeur'         AS title,
    '/a_panels/panel_editor.sql' AS link;
 SELECT 
    'Retour à la liste des projets'            AS title,
    '/e_project/project_main_display_3.sql'     AS link;   
SELECT 
    'Gestion des lieux'            AS title,
    '/e_project_meeting/project_meeting_place_display_3.sql'      AS link;

SELECT 
    'map'   AS component,
    'Carte des lieux de réunion' AS title,
    11   AS zoom,
    $tile_latitude  AS latitude,
    $tile_longitude  AS longitude,
    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png' AS tile_source;

SELECT 
    project_meeting_place_name               AS title,
    'indigo'                    AS color,
    'map-pin'                   AS icon,
    'http://localhost:8080/e_project_meeting/project_meeting_place_profile_4.sql?project_meeting_place_id='||project_meeting_place_id AS link,
     project_meeting_place_latitude           AS latitude,
     project_meeting_place_longitude         AS longitude
     FROM project_meeting_places;
    




