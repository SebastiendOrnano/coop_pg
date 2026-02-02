SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_3.sql') AS properties;

SET project_id = SELECT project_id FROM project_plots WHERE plot_id = $plot_id::INTEGER;

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
    '/e_project_plots/plot_main_display_3.sql?project_id='||$project_id     AS link; 
    
SELECT 
    'map'   AS component,
    'Carte de nos projets' AS title,
    16 AS zoom,
    150 AS height,
    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png' AS tile_source;
SELECT 
    plot_title               AS title,
    CASE
    WHEN GeometryType(plot_geom) = 'POINT' 
    THEN 'building' 
    ELSE ''
    END AS icon,
        CASE
    WHEN GeometryType(plot_geom) = 'POLYGON' 
    THEN 'blue' 
    ELSE ''
    END AS color,
    ST_AsGeoJSON(plot_geom)  AS geojson
    FROM project_plots
    WHERE plot_id=$plot_id::INTEGER;

SELECT 
    'form' AS component,
    '' AS validate,
    'Description de la parcelle' AS title;

SELECT
    'plot_title' AS name,
    'text' AS type,  
    'Nom' AS label,
    12 AS width,
    TRUE AS readonly,
    (SELECT plot_title  FROM project_plots WHERE plot_id = $plot_id::INTEGER ) AS value;

 SELECT 
    'plot_status'        AS name,
    'Statut'                 AS label,
    'text'                 AS type,
    TRUE AS readonly,
    2                        AS width,
    (SELECT plot_status  FROM project_plots WHERE plot_id = $plot_id::INTEGER ) AS value;

 SELECT 
    'plot_area'        AS name,
    'Superficie en m2'                 AS label,
    'text'                 AS type,
    TRUE AS readonly,
    2                        AS width,
    (SELECT  ROUND(ST_Area(plot_geom::geography))::integer FROM project_plots WHERE plot_id = $plot_id::INTEGER ) AS value;

SELECT
    'plot_postal_code' AS name,
    'text' AS type,  
    'Code postal' AS label,
    TRUE AS readonly,
    2                       AS width,
    (SELECT plot_description  FROM project_plots WHERE plot_id = $plot_id::INTEGER ) AS value;

SELECT
    'plot_code_land_registry' AS name,
    'text' AS type,  
    'N° parcelle cadastrale' AS label,
    TRUE AS readonly,
    2                        AS width,
    (SELECT plot_code_land_registry  FROM project_plots WHERE plot_id = $plot_id::INTEGER ) AS value;

SELECT 
   'building_id' AS name,
    'Bâtiment en lien avec la parcelle' AS label,
    'text' AS type,
    4 AS width,
    (SELECT building_name  FROM project_building AS b 
    LEFT JOIN (SELECT building_id, plot_id from project_plots) AS l
    on b.building_id = l.building_id
    WHERE l.plot_id = $plot_id::INTEGER ) AS value;

SELECT
    'plot_description' AS name,
    'textarea' AS type,  
    'Description' AS label,
    TRUE AS readonly,
    (SELECT plot_description  FROM project_plots WHERE plot_id = $plot_id::INTEGER ) AS value;



