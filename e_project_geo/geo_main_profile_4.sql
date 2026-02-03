SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SET project_id = SELECT project_id FROM project_geo WHERE geo_id=$geo_id::NTEGER;


SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion superviseur'         AS title,
    '/a_panels/panel_supervisor_4.sql' AS link;
 SELECT 
    'Projets'            AS title,
    '/e_project/project_main_display_4.sql'     AS link;   
 SELECT 
    'Hub du projet'            AS title,
    '/e_project/project_hub_display_4.sql?project_id='||$project_id     AS link; 
SELECT 
    'Gestion des parcelles'            AS title,
    '/e_project_geo/geo_main_display_4.sql?project_id='||$project_id     AS link;

SELECT 
    'map'   AS component,
    'Carte de nos projets' AS title,
    16 AS zoom,
    150 AS height,
    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png' AS tile_source;
SELECT 
    geo_title               AS title,
    CASE
    WHEN GeometryType(geo_geom) = 'POINT' 
    THEN 'building' 
    ELSE ''
    END AS icon,
        CASE
    WHEN GeometryType(geo_geom) = 'POLYGON' 
    THEN 'blue' 
    ELSE ''
    END AS color,
    ST_AsGeoJSON(geo_geom)  AS geojson
    FROM project_geo
    WHERE geo_id=$geo_id::INTEGER;

SELECT 
    'form' AS component,
    '' AS validate,
    'Description de la parcelle' AS title;

SELECT
    'geo_title' AS name,
    'text' AS type,  
    'Nom' AS label,
    12 AS width,
    TRUE AS readonly,
    (SELECT geo_title  FROM project_geo WHERE geo_id=$geo_id::NTEGER ) AS value;

 SELECT 
    'geo_status'        AS name,
    'Statut'                 AS label,
    'text'                 AS type,
    TRUE AS readonly,
    2                        AS width,
    (SELECT geo_status  FROM project_geo WHERE geo_id=$geo_id::NTEGER ) AS value;

 SELECT 
    'geo_area'        AS name,
    'Superficie en m2'                 AS label,
    'text'                 AS type,
    TRUE AS readonly,
    2                        AS width,
    (SELECT  ROUND(ST_Area(geo_geom::geography))::integer FROM project_geo WHERE geo_id=$geo_id::NTEGER ) AS value;

SELECT
    'geo_postal_code' AS name,
    'text' AS type,  
    'Code postal' AS label,
    TRUE AS readonly,
    2                       AS width,
    (SELECT geo_description  FROM project_geo WHERE geo_id=$geo_id::NTEGER ) AS value;

SELECT
    'geo_code_land_registry' AS name,
    'text' AS type,  
    'N° parcelle cadastrale' AS label,
    TRUE AS readonly,
    2                        AS width,
    (SELECT geo_code_land_registry  FROM project_geo WHERE geo_id=$geo_id::NTEGER ) AS value;

SELECT 
   'building_id' AS name,
    'Bâtiment en lien avec la parcelle' AS label,
    'text' AS type,
    4 AS width,
    (SELECT building_name  FROM project_building AS b 
    LEFT JOIN (SELECT building_id, geo_id from project_geo) AS l
    on b.building_id = l.building_id
    WHERE l.geo_id=$geo_id::NTEGER ) AS value;

SELECT
    'geo_description' AS name,
    'textarea' AS type,  
    'Description' AS label,
    TRUE AS readonly,
    (SELECT geo_description  FROM project_geo WHERE geo_id=$geo_id::NTEGER ) AS value;



