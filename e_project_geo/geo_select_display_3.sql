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
    'Gestion des parcelles'            AS title,
    '/e_project_geo/geo_main_display_3.sql?project_id='||$project_id     AS link; 


SELECT 
    'datagrid'              AS component,
    'panel_project_geo_doc_display' AS id,
    'Traitement sur une selection de parcelles' AS title;
SELECT 
    '/e_project_geo/geo_select_all_0.sql?project_id='||$project_id      AS link,
    'Tout sélectionner'                                      AS description,
    'list-check'                                     AS icon,
    'red'                                               AS color;
SELECT 
    '/e_project_geo/geo_select_no_0.sql?project_id='||$project_id     AS link,
    'Annuler toute la sélection'               AS description,
    'stack'                                    AS icon,
    'red'                                   AS color;
SELECT 
    '/e_project_geo/geo_select_edit_4.sql?project_id='||$project_id     AS link,
    'Actualiser des données sur les parcelles sélectionnées'       AS description,
    'refresh'                                  AS icon,
    'blue'                                   AS color;
SELECT 
    '/e_project_geo/geo_select_delete_0.sql?project_id='||$project_id      AS link,
    'Supprimer les parcelles sélectionnées'       AS description,
    'books'                                    AS icon,
    'yellow'                                   AS color;
SELECT 
     '/e_project_geo/geo_geojson_export_selected_0.sql?project_id='||$project_id             AS link,
    'Exporter toutes les parcelles liées au projet'                                         AS description,
    'file-download'                                                                           AS icon,
    'yellow'                                                                               AS color;



SELECT 
    'table'                 AS component, 
    'Liste des documents'   AS title, 
    'View'                  AS markdown,
    'Titre'                  AS markdown,
    'download_selection_table' AS id,
    TRUE                   AS sort, 
    TRUE                   AS search;

SELECT  
    geo_id        AS Id,
    geo_title    AS Titre,
    geo_status    AS statut,
    geo_selected  AS selected,
  '[select / unselect](geo_select_yes_0.sql?geo_id='||geo_id||')'    AS View
FROM project_geo
WHERE project_id = $project_id::INTEGER
ORDER BY created_at DESC;




