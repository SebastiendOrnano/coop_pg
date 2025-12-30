SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell.sql') AS properties;


SELECT 
    'button'                                      AS component;
SELECT
    'Retour à l''évévenement'                     AS title,
    'green'                                       AS color,
    '/b_events/event_poster.sql?event_id='||$event_id AS link;

SELECT
    'map'   AS component,    
    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png' AS tile_source,
    12   AS zoom;

SELECT
    'Lieu de l''évenement' AS title,
    place_latitude  AS latitude,
    place_longitude AS longitude
    FROM place
    WHERE place_id=$place_id::INTEGER;
