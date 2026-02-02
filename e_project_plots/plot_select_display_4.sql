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
    '/e_project_plots/plot_main_display_4.sql?project_id='||$project_id     AS link;


SELECT 
    'datagrid'              AS component,
    'panel_project_plots_doc_display' AS id,
    'Traitement sur une selection de parcelles' AS title;
SELECT 
    '/e_project_plots/plot_select_all_0.sql?project_id='||$project_id      AS link,
    'Tout sélectionner'                                      AS description,
    'list-check'                                     AS icon,
    'red'                                               AS color;
SELECT 
    '/e_project_plots/plot_select_no_0.sql?project_id='||$project_id     AS link,
    'Annuler toute la sélection'               AS description,
    'stack'                                    AS icon,
    'red'                                   AS color;
SELECT 
    '/e_project_plots/plot_select_edit_4.sql?project_id='||$project_id     AS link,
    'Actualiser des données sur les parcelles sélectionnées'       AS description,
    'refresh'                                  AS icon,
    'blue'                                   AS color;
SELECT 
    '/e_project_plots/plot_select_delete_0.sql?project_id='||$project_id      AS link,
    'Supprimer les parcelles sélectionnées'       AS description,
    'books'                                    AS icon,
    'yellow'                                   AS color;
SELECT 
     '/e_project_plots/plot_geojson_export_selected_0.sql?project_id='||$project_id             AS link,
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
    plot_id        AS Id,
    plot_title    AS Titre,
    plot_status    AS statut,
    plot_selected  AS selected,
  '[select / unselect](plot_select_yes_0.sql?plot_id='||plot_id||')'    AS View
FROM project_plots
WHERE project_id = $project_id::INTEGER
ORDER BY created_at DESC;




