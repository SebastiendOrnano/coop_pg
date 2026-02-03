-- Définir le rôle utilisateur et redirection
SET user_role = (
    SELECT user_role FROM users
    INNER JOIN sessions ON users.user_id = sessions.user_id
    WHERE sessions.session_token = sqlpage.cookie('session_token')
); 

SET redirect_link =
CASE WHEN $user_role = 'supervisor' 
THEN  '/e_project_geo/geo_main_display_4.sql?project_id='||$project_id
ELSE  '/e_project_geo/geo_main_display_3.sql?project_id='||$project_id
END;


WITH file_content AS (
    SELECT
        sqlpage.read_file_as_text(
            sqlpage.uploaded_file_path('geojson_collection_input')
        )::jsonb AS geojson
),
feature_collection AS (
    SELECT geojson
    FROM file_content
    WHERE geojson->>'type' = 'FeatureCollection'
),
features AS (
    SELECT
        to_jsonb(jsonb_array_elements(geojson->'features')::json) AS feature
    FROM feature_collection
),
extracted_features AS (
    SELECT
        (feature->'properties'->>'id')::text AS geo_id_from_file,
        feature->'properties'               AS properties,
        feature->'geometry'                 AS geometry
    FROM features
),

insert_data AS (
    INSERT INTO project_geo (project_id, geo_code_land_registry, geo_postal_code, geo_title, geo_description, geo_geom, geo_last_updated, geo_status)
    SELECT
        $project_id::integer,
        COALESCE((properties->>'id'),'00000')::TEXT AS geo_code_land_registry,
        COALESCE((properties->>'commune'),'00000') AS geo_postal_code,
        COALESCE(
            (properties->>'commune') || ' - ' || (properties->>'id'),
            properties->>'id',
            'Parcelle sans informations'
        ) AS geo_title,
        CONCAT_WS(
            ' / ',
            'Section: ' || COALESCE(properties->>'section', 'NC'),
            'Contenance: ' || COALESCE(properties->>'contenance', '0') || ' m²',
            'Commune: ' || COALESCE(properties->>'commune', 'NC'),
            'Dernière mise à jour: ' || COALESCE(properties->>'updated', 'NC')
        ) AS geo_description,
        ST_SetSRID(
            ST_GeomFromGeoJSON(geometry),
            4326
        ) AS geo_geom,
        COALESCE((properties->>'updated'),'1970-01-01')::DATE AS geo_last_updated,
        'active' AS geo_status
    FROM extracted_features
    WHERE NOT EXISTS (
        SELECT 1
        FROM project_geo
        WHERE geo_code_land_registry = extracted_features.geo_id_from_file 
          AND project_id = $project_id::integer
    )
    RETURNING geo_id)
SELECT 'redirect' AS component,
       $redirect_link AS link;
