SELECT
    'http_header' AS component,
    format('attachment; filename="project_id_%s.geojson"', $project_id) AS "Content-Disposition";

-- to select alls columns as properties

SELECT
   'json' AS component,
  jsonb_build_object(
    'type', 'FeatureCollection',
    'features', jsonb_agg(ST_AsGeoJSON(pp.*)::jsonb)
  )::text AS contents
FROM project_geo pp
WHERE pp.project_id = $project_id::integer AND pp.geo_selected=TRUE;

/*
-- to select specific columns as properties

SELECT
   'json' AS component,
   jsonb_build_object(
     'type', 'FeatureCollection',
     'features', jsonb_agg(
       jsonb_build_object(
         'type', 'Feature',
         'geometry', ST_AsGeoJSON(pp.geo_geom)::jsonb,
         'properties', jsonb_build_object(
           'geo_id', pp.geo_id,
           'project_id', pp.project_id,
           'geo_title', pp.geo_title,
           'geo_description', pp.geo_description,
           'building_id', pp.building_id,
           'geo_code_postal', pp.geo_code_postal,
           'geo_code_land_registry', pp.geo_code_land_registry,
           'geo_code_insee', pp.geo_code_insee
         )
       )
     )
   )::text AS contents
FROM project_geo pp
WHERE pp.project_id = $project_id::integer AND pp.geo_selected=TRU

*/
