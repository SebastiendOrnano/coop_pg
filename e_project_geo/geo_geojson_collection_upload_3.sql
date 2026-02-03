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
    'form'                 AS component,
    'geojson data'         AS title,
    'Load data'            AS validate,
    '/e_project_geo/geo_geojson_collection_create_0.sql?project_id='||$project_id AS action;
SELECT 
    'geojson_collection_input'                      AS name,
    'file'                                          AS type,
    'application/geo+json'                          AS accept,
    'Fichier geojson complexe (collection)'          AS label,
    'Upload coordo of a land plot'                   AS description,
    TRUE                                             AS required;