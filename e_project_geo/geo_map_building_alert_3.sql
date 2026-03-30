SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SET project_id = SELECT project_id FROM project_geo_group WHERE geo_group_id = $geo_group_id::INTEGER;

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
    'Gestion des groupes topo'                                                AS title,
    '/e_project_geo/geo_group_display_4.sql?project_id='||$project_id     AS link;
SELECT 
    'Gestion des éléments topo'                                                AS title,
    '/e_project_geo/geo_main_display_4.sql?geo_group_id='||$geo_group_id     AS link;

SELECT 
    'alert'                     AS component,
    TRUE AS important,
    'Aucune parcelle ni point ni ligne n''est associée à ce bâtiment' AS description,
    'alert-triangle'            AS icon,
      TRUE                       AS dismissible,
    'yellow'                    AS color;