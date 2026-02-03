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
    'form' AS component,
    'Créer un traçé à partir de coordonnées' AS title,
    'Créer' AS validate,
    'Clear' AS reset,
    '/e_project_geo/geo_coordo_create_0.sql?project_id='||$project_id AS action;

SELECT
    'geo_title' AS name,
    'text' AS type,  
    'Nom' AS label,
    5 AS width,
    TRUE AS required;

SELECT 
   'building_id' AS name,
   'Bâtiment en lien avec la parcelle' AS label,
    'select' AS type,
    5 AS width,
    'Sélectionner un bâtiment...' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',m.building_name,'value',m.building_id)) AS options
    FROM project_building AS m
    WHERE m.project_id = $project_id::INTEGER;
SELECT
    'geo_code_postal' AS name,
    'text' AS type,  
    'Nom' AS label,
    2 AS width,
    TRUE AS required;

SELECT 
    'geo_coordo'          AS name,
    'Coordo'          AS label,
    '[[long1,lat1],long2,lat2],[long3,lat3],[],[],[],[]]' AS description,
    'text'            AS type, 
    TRUE              AS required,
    12                AS width;

SELECT
    'geo_description' AS name,
    'textarea' AS type,  
    'Présentation la parcelle' AS label;
