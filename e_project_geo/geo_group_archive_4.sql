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
    'Gestion des parcelles'            AS title,
    '/e_project_geo/geo_group_display_4.sql?project_id='||$project_id     AS link; 



SELECT 'table' AS component, 
    'Liste des groupes topo'   AS title, 

    JSON('{"name":"Éléments","tooltip":"Afficher les éléments du groupe","link":"/e_project_geo/geo_main_display_4.sql?geo_group_id={id}","icon":"file-spreadsheet"}') AS custom_actions,
    JSON('{"name":"UnArchive","tooltip":"Désarchiver le groupe","link":"/e_project_geo/geo_group_archive_remove_0.sql?geo_group_id={id}","icon":"archive-off"}') AS custom_actions,
    '/e_project_geo/geo_group_edit_4.sql?geo_group_id={id}' AS edit_url,
    '/e_project_geo/geo_group_delete_alert_4.sql?geo_group_id={id}' AS delete_url,
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
            "link":"/e_project_geo/geo_group_map_4.sql?geo_group_id={id}",
            "icon":"map"
        }')
        ELSE JSON('{"name":"Map"}')
    END AS _sqlpage_actions
FROM project_geo_group AS p 
WHERE p.project_id = $project_id::INTEGER 
AND p.geo_group_status ='archived' 
ORDER BY p.geo_group_id ASC;


