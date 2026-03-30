SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SET project_id = SELECT project_id FROM project_geo_group WHERE geo_group_id=$geo_group_id::INTEGER ;


SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion Superviseur'              AS title,
    '/a_panels/panel_supervisor_4.sql' AS link;
 SELECT 
    'Projets'                                    AS title,
    '/e_project/project_main_display_4.sql'     AS link;   
 SELECT 
    'Hub du projet'                                                     AS title,
    '/e_project/project_hub_display_4.sql?project_id='||$project_id     AS link;   
SELECT 
    'Gestion des groupes topo'            AS title,
    '/e_project_geo/geo_group_display_4.sql?project_id='||$project_id     AS link; 
SELECT 
    'Gestion des éléments topo'                                                AS title,
    '/e_project_geo/geo_main_display_4.sql?geo_group_id='||$geo_group_id     AS link;



SELECT 'table' AS component, 
    'Gestion des éléments topo archivés' AS title,
    JSON('{"name":"Map","tooltip":"Localiser la parcelle ou le point","link":"/e_project_geo/geo_map_display_4.sql?geo_id={id}","icon":"map-pin-check"}') AS custom_actions,
    JSON('{"name":"Data","tooltip":"Données","link":"/e_project_geo/geo_main_profile_4.sql?geo_id={id}","icon":"file-spreadsheet"}') AS custom_actions,
    JSON('{"name":"Export","tooltip":"Exorter sous forme de fichier geojson","link":"/e_project_geo/geo_geojson_export_single_0.sql?geo_id={id}","icon":"file-download"}') AS custom_actions,
    JSON('{"name":"Unarchive","tooltip":"Désarchiver le point ou la parcelle","link":"/e_project_geo/geo_archive_remove_0.sql?geo_id={id}","icon":"archive-off"}') AS custom_actions,
    '/e_project_geo/geo_main_edit_4.sql?geo_id={id}' AS edit_url,
    '/e_project_geo/geo_main_delete_alert_4.sql?geo_id={id}' AS delete_url,
    TRUE             AS sort, 
    TRUE             AS search;

SELECT
    p.geo_id                AS Id,
    p.geo_id                AS _sqlpage_id,
    p.geo_title             AS Nom,
    b.building_name          AS Batiment
FROM project_geo AS p 
LEFT JOIN (select building_id, building_name from project_building) AS b 
ON p.building_id=b.building_id
WHERE p.geo_group_id = $geo_group_id::INTEGER 
AND geo_status ='archived' 
ORDER BY geo_id ASC;


