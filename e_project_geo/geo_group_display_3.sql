SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_3.sql') AS properties;

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
    'datagrid'                         AS component,
    'panel_geo_display'               AS id,
    'Gestion des parcelles de terrain' AS title;
SELECT 
    '/e_project_geo/geo_group_form_4.sql?project_id='||$project_id     AS link,
    'Création d''un groupe de traçés'                                     AS description,
    'route'                                                                AS icon,
    'green'                                                                AS color;
SELECT 
     '/e_project_geo/geo_map_display_all_4.sql?project_id='||$project_id             AS link,
    'Visualiser toutes les parcelles et points d''un projet'                            AS description,
    'map-2'                                                                             AS icon,
    'green'                                                                             AS color;
SELECT 
     '/e_project_geo/geo_geojson_export_collection_project_0.sql?project_id='||$project_id             AS link,
    'Exporter toutes les parcelles liées au projet'                                         AS description,
    'file-download'                                                                           AS icon,
    'yellow'                                                                               AS color;


SELECT 'table' AS component, 
    'Liste des groupes topo'   AS title, 
    JSON('{"name":"Éléments","tooltip":"Afficher les éléments du groupe","link":"/e_project_geo/geo_main_display_3.sql?geo_group_id={id}","icon":"file-spreadsheet"}') AS custom_actions,
    JSON('{"name":"Export","tooltip":"Exorter sous forme de fichier geojson","link":"/e_project_geo/geo_geojson_export_collection_group_0.sql?geo_group_id={id}","icon":"file-download"}') AS custom_actions,
    JSON('{"name":"Archive","tooltip":"Archiver le groupe","link":"/e_project_geo/geo_group_archive_0.sql?geo_group_id={id}","icon":"archive"}') AS custom_actions,
    '/e_project_geo/geo_group_edit_3.sql?geo_group_id={id}' AS edit_url,
    TRUE             AS sort, 
    TRUE             AS search;

SELECT
    p.geo_group_id                AS Id,
    p.geo_group_id                AS _sqlpage_id,
    p.geo_group_title             AS Nom,
    p.geo_group_rank              AS Niveau,
        CASE
        WHEN EXISTS (
            SELECT 1
            FROM project_geo g
            WHERE g.geo_group_id = p.geo_group_id
        )
        THEN JSON('{
            "name":"Map",
            "tooltip":"Carte des éléments du groupe",
            "link":"/e_project_geo/geo_group_map_3.sql?geo_group_id={id}",
            "icon":"map"
        }')
        ELSE JSON('{"name":"Map"}')
    END AS _sqlpage_actions
FROM project_geo_group AS p 
WHERE p.project_id = $project_id::INTEGER 
AND p.geo_group_status !='archived' 
ORDER BY p.geo_group_id ASC;


