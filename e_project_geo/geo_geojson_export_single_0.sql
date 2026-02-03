SELECT
    'http_header' AS component,
    format('attachment; filename="geo_id_%s.geojson"', $geo_id) AS "Content-Disposition";

SELECT
    'json' AS component,
    ST_AsGeoJSON(pp.*)::jsonb AS contents
FROM project_geo pp
WHERE pp.geo_id=$geo_id::NTEGER;

/*
-- to select only few properties

SELECT
    'json' AS component,
    (
      SELECT json_build_object(
        'type', 'Feature',
        'geometry', ST_AsGeoJSON(geo_geom)::jsonb,
        'properties', jsonb_build_object(
          'geo_id', geo_id,
          'project_id', project_id,
          'geo_title', geo_title,
          'geo_description', geo_description,
          'building_id', building_id,
          'geo_code_postal', geo_code_postal,
          'geo_code_land_registry', geo_code_land_registry,
          'geo_code_insee', geo_code_insee
        )
      )
      FROM project_geo
      WHERE geo_id=$geo_id::NTEGER
    ) AS contents;

*/




