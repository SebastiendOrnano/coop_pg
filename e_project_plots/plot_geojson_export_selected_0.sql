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
FROM project_plots pp
WHERE pp.project_id = $project_id::integer AND pp.plot_selected=TRUE;

/*
-- to select specific columns as properties

SELECT
   'json' AS component,
   jsonb_build_object(
     'type', 'FeatureCollection',
     'features', jsonb_agg(
       jsonb_build_object(
         'type', 'Feature',
         'geometry', ST_AsGeoJSON(pp.plot_geom)::jsonb,
         'properties', jsonb_build_object(
           'plot_id', pp.plot_id,
           'project_id', pp.project_id,
           'plot_title', pp.plot_title,
           'plot_description', pp.plot_description,
           'building_id', pp.building_id,
           'plot_code_postal', pp.plot_code_postal,
           'plot_code_land_registry', pp.plot_code_land_registry,
           'plot_code_insee', pp.plot_code_insee
         )
       )
     )
   )::text AS contents
FROM project_plots pp
WHERE pp.project_id = $project_id::integer AND pp.plot_selected=TRU

*/
