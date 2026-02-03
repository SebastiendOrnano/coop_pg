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

WITH
params AS (
    SELECT
        :geo_title       AS geo_title,
        :geo_status      AS geo_status,
        :geo_description AS geo_description,
        :geo_coordo::jsonb AS coordo_json
),

pts AS (
    SELECT
        geo_title,
        geo_status,
        geo_description,
        coordo_json,
        coordo_json                      AS coords_array,
        jsonb_array_length(coordo_json)  AS n_pts
    FROM params
),

analysis AS (
    SELECT
        geo_title,
        geo_status,
        geo_description,
        coords_array,
        n_pts,
        coords_array->0                                   AS first_pt,
        coords_array->(n_pts-1)                           AS last_pt
    FROM pts
),

geom_type AS (
    SELECT
        geo_title,
        geo_status,
        geo_description,
        coords_array,
        n_pts,
        CASE
            WHEN n_pts = 1 THEN 'POINT'
            WHEN n_pts = 2 THEN 'LINESTRING'
            WHEN n_pts  > 2 AND first_pt = last_pt THEN 'POLYGON'
            WHEN n_pts  > 1 THEN 'LINESTRING'
            ELSE 'POINT'
        END AS gtype
    FROM analysis
),

wkt_coords AS (
    SELECT
        geo_title,
        geo_status,
        geo_description,
        gtype,
        string_agg(
            (pt->>0) || ' ' || (pt->>1),
            ', '
            ORDER BY i
        ) AS coords_list
    FROM (
        SELECT
            g.geo_title,
            g.geo_status,
            g.geo_description,
            g.gtype,
            i,
            g.coords_array->i AS pt
        FROM geom_type g
        JOIN generate_series(0, jsonb_array_length(g.coords_array)-1) AS i
          ON TRUE
    ) s
    GROUP BY geo_title, geo_status, geo_description, gtype
),

geom_3d AS (
    SELECT
        geo_title,
        geo_status,
        geo_description,
        CASE
            WHEN gtype = 'POINT' THEN
                ST_Force3D(
                    ST_SetSRID(
                        ST_GeomFromText('POINT(' || coords_list || ')', 4326),
                        4326
                    ),
                    0.0
                )
            WHEN gtype = 'LINESTRING' THEN
                ST_Force3D(
                    ST_SetSRID(
                        ST_GeomFromText('LINESTRING(' || coords_list || ')', 4326),
                        4326
                    ),
                    0.0
                )
            WHEN gtype = 'POLYGON' THEN
                ST_Force3D(
                    ST_SetSRID(
                        ST_GeomFromText('POLYGON((' || coords_list || '))', 4326),
                        4326
                    ),
                    0.0
                )
        END AS geom_3d
    FROM wkt_coords
)

INSERT INTO project_geo (
    project_id,
    geo_title,
    geo_code_postal,
    geo_status,
    geo_description,
    geo_geom
)
SELECT
    $project_id::integer,
    :geo_code_postal,
    geo_title,
    'active',
    geo_description,
    geom_3d
FROM geom_3d


RETURNING 'redirect' AS component,
         $redirect_link AS link;
