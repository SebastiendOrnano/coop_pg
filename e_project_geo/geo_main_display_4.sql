SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

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
    'datagrid'                         AS component,
    'panel_geo_display'               AS id,
    'Gestion des parcelles de terrain' AS title;
SELECT 
    '/e_project_geo/geo_coordo_form_4.sql?project_id='||$project_id     AS link,
    'Création d''un tracé'                                                 AS description,
    'route'                                                                AS icon,
    'green'                                                                AS color;
SELECT 
    '/e_project_geo/geo_geojson_single_upload_4.sql?project_id='||$project_id     AS link,
    'Charger un fichier geojson simple'                                              AS description,
    'upload'                                                                         AS icon,
    'blue'                                                                           AS color;
SELECT 
    '/e_project_geo/geo_geojson_collection_upload_4.sql?project_id='||$project_id     AS link,
    'Charger un fichier geojson complexe'                                                AS description,
    'upload'                                                                             AS icon,
    'red'                                                                                AS color;
SELECT 
     '/e_project_geo/geo_map_display_all_4.sql?project_id='||$project_id             AS link,
    'Visualiser toutes les parcelles et points d''un projet'                            AS description,
    'map-2'                                                                             AS icon,
    'green'                                                                             AS color;
SELECT 
     '/e_project_geo/geo_map_building_form_4.sql?project_id='||$project_id             AS link,
    'Visualiser toutes les parcelles et points d''un bâtiment'                        AS description,
    'map-2'                                                                           AS icon,
    'red'                                                                             AS color;
SELECT 
     '/e_project_geo/geo_archive_display_4.sql?project_id='||$project_id             AS link,
    'Visualiser les parcelles et points archivés'                                       AS description,
    'archive'                                                                           AS icon,
    'red'   
SELECT 
     '/e_project_geo/geo_select_display_4.sql?project_id='||$project_id             AS link,
    'Actualiser un lot de points et parcelles'                                         AS description,
    'checkup-list'                                                                           AS icon,
    'green'                                                                               AS color;
SELECT 
     '/e_project_geo/geo_geojson_export_collection_0.sql?project_id='||$project_id             AS link,
    'Exporter toutes les parcelles liées au projet'                                         AS description,
    'file-download'                                                                           AS icon,
    'yellow'                                                                               AS color;


SELECT 'table' AS component, 
    'Liste des salles'   AS title, 
    JSON('{"name":"Map","tooltip":"Localiser la parcelle ou le point","link":"/e_project_geo/geo_map_display_4.sql?geo_id={id}","icon":"map-pin-check"}') AS custom_actions,
    JSON('{"name":"Data","tooltip":"Données","link":"/e_project_geo/geo_main_profile_4.sql?geo_id={id}","icon":"file-spreadsheet"}') AS custom_actions,
    JSON('{"name":"Export","tooltip":"Exorter sous forme de fichier geojson","link":"/e_project_geo/geo_geojson_export_single_0.sql?geo_id={id}","icon":"file-download"}') AS custom_actions,
    JSON('{"name":"Archive","tooltip":"Archiver le point ou la parcelle","link":"/e_project_geo/geo_archive_0.sql?geo_id={id}","icon":"archive"}') AS custom_actions,
    '/e_project_geo/geo_main_edit_4.sql?geo_id={id}' AS edit_url,
    '/e_project_geo/geo_main_delete_alert_4.sql?geo_id={id}' AS delete_url,
    TRUE             AS sort, 
    TRUE             AS search;

SELECT
    p.geo_id                AS Id,
    p.geo_id                AS _sqlpage_id,
    p.geo_title             AS Nom,
    b.building_name          AS Batiment,
    p.geo_code_insee        AS CodeInsee,
    p.geo_code_postal       AS CodePostal
FROM project_geo AS p 
LEFT JOIN (select building_id, building_name from project_building) AS b 
ON p.building_id=b.building_id
WHERE project_id = $project_id::INTEGER 
AND geo_status !='archived' 
ORDER BY geo_id ASC;


