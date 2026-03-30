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

-- Insertion directe pour Feature unique
-- Version directe (recommandée)
WITH file_content AS (
    SELECT 
        sqlpage.read_file_as_text(sqlpage.uploaded_file_path('geo_data_input'))::jsonb AS geojson
),
insert_data AS (
    INSERT INTO project_geo (project_id,geo_title, geo_description, geo_status,  geo_geom, created_at)
    SELECT
        $project_id::INTEGER,
        COALESCE(geojson->'properties'->>'name', 'Parcelle sans nom'),
        COALESCE(geojson->'properties'->>'description', '---'),
        'active',
        ST_Force3D(ST_SetSRID(ST_GeomFromGeoJSON(geojson->>'geometry'), 4326)),
        CURRENT_TIMESTAMP
    FROM file_content
    RETURNING geo_id)

SELECT 'redirect' AS component,
         $redirect_link AS link;