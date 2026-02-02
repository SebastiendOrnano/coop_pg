SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;



SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion superviseur'         AS title,
    '/a_panels/panel_supervisor.sql' AS link;
 SELECT 
    'Projets'            AS title,
    '/e_project/project_main_display_4.sql'     AS link;   
 SELECT 
    'Hub du projet'            AS title,
    '/e_project/project_hub_display_4.sql?project_id='||$project_id     AS link; 
SELECT 
    'Gestion des parcelles'            AS title,
    '/e_project_plots/plot_main_display_4.sql?project_id='||$project_id     AS link; 
     
SELECT 
    'form' AS component,
    'Choisir le bâtiment' AS title,
    'Créer' AS validate,
    'Clear' AS reset,
    '/e_project_plots/plot_map_building_display_test_0.sql?project_id='||$project_id AS action;

SELECT 
   'building_id' AS name,
   'Bâtiment en lien avec la parcelle' AS label,
    'select' AS type,
    5 AS width,
    'Sélectionner un bâtiment...' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',m.building_name,'value',m.building_id)) AS options
    FROM project_building AS m
    WHERE m.project_id = $project_id::INTEGER;

