SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion superviseur'               AS title,
    '/a_panels/panel_supervisor_4.sql' AS link;
 SELECT 
    'Projets'                                   AS title,
    '/e_project/project_main_display_4.sql'     AS link;   
 SELECT 
    'Hub du projet'                                                     AS title,
    '/e_project/project_hub_display_4.sql?project_id='||$project_id     AS link; 
SELECT 
    'Gestion des parcelles'                                                AS title,
    '/e_project_geo/geo_main_display_4.sql?project_id='||$project_id     AS link;

SELECT 
'title' as component,
'Parcelles et points archivés' as contents;

SELECT 'table' AS component, 
    'Liste des salles'   AS title, 
    JSON('{"name":"Map","tooltip":"Localiser la parcelle ou le point","link":"/e_project_geo/geo_map_display_4.sql?geo_id={id}","icon":"map-pin-check"}') AS custom_actions,
    JSON('{"name":"Data","tooltip":"Données","link":"/e_project_geo/geo_main_profile_4.sql?geo_id={id}","icon":"file-spreadsheet"}') AS custom_actions,
     JSON('{"name":"UnArchive","tooltip":"Désarchiver le point ou la parcelle","link":"/e_project_geo/geo_archive_remove_0.sql?geo_id={id}","icon":"archive-off"}') AS custom_actions,
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
AND geo_status ='archived' 
ORDER BY geo_id ASC;


