SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_3.sql') AS properties;

SET project_id = SELECT project_id FROM project_building WHERE building_id = $building_id::INTEGER;


SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion éditeur'         AS title,
    '/a_panels/panel_editor.sql' AS link;
 SELECT 
    'Projets'            AS title,
    '/e_project/project_main_display_3.sql'     AS link;   
 SELECT 
    'Hub du projet'            AS title,
    '/e_project/project_hub_display_3.sql?project_id='||$project_id     AS link;
SELECT 
    'Gestion des parcelles'            AS title,
    '/e_project_geo/geo_main_display_3.sql?project_id='||$project_id     AS link; 

SELECT 
    'alert'                     AS component,
    TRUE AS important,
    'Aucune parcelle ni point ni ligne n''est associée à ce bâtiment' AS description,
    'alert-triangle'            AS icon,
      TRUE                       AS dismissible,
    'yellow'                    AS color;