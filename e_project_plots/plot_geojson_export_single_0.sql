SELECT
    'http_header' AS component,
    format('attachment; filename="plot_id_%s.geojson"', $plot_id) AS "Content-Disposition";

SELECT
    'json' AS component,
    ST_AsGeoJSON(pp.*)::jsonb AS contents
FROM project_plots pp
WHERE pp.plot_id = $plot_id::integer;

/*
-- to select only few properties

SELECT
    'json' AS component,
    (
      SELECT json_build_object(
        'type', 'Feature',
        'geometry', ST_AsGeoJSON(plot_geom)::jsonb,
        'properties', jsonb_build_object(
          'plot_id', plot_id,
          'project_id', project_id,
          'plot_title', plot_title,
          'plot_description', plot_description,
          'building_id', building_id,
          'plot_code_postal', plot_code_postal,
          'plot_code_land_registry', plot_code_land_registry,
          'plot_code_insee', plot_code_insee
        )
      )
      FROM project_plots
      WHERE plot_id = $plot_id::integer
    ) AS contents;

*/




