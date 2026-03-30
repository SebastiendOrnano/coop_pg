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
    'Gestion des groupes topo'            AS title,
    '/e_project_geo/geo_group_display_4.sql?project_id='||$project_id     AS link; 
SELECT 
    'Gestion des parcelles'                                                AS title,
    '/e_project_geo/geo_main_display_4.sql?geo_group_id='||$geo_group_id     AS link;




SELECT 
    'map'   AS component,
    'Carte de nos projets' AS title,
    16 AS zoom,
    'https://{s}.tile.openstreetmap.fr/osmfr/{z}/{x}/{y}.png' AS tile_source;
SELECT 
    geo_title               AS title,
    CASE
    WHEN GeometryType(geo_geom) = 'POINT' 
    THEN 'building' 
    ELSE ''
    END AS icon,
    CASE
    WHEN GeometryType(geo_geom) = 'LINESTRING'
    THEN 'green' 
    ELSE 'blue'
    END AS color,
    geo_description AS description,
    'http://localhost:8080/e_project_geo/geo_main_profile_4.sql?geo_id='||geo_id::INTEGER AS link,
    ST_AsGeoJSON(geo_geom)  AS geojson
    FROM project_geo AS g
    LEFT JOIN (select geo_group_id, project_id FROM project_geo_group) AS p
    ON p.geo_group_id=g.geo_group_id
    WHERE p.project_id=$project_id::INTEGER;
