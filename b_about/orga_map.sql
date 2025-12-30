SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell.sql') AS properties;


SELECT 
    'map'   AS component,
    'Où nous trouver ?' AS title,
    9  AS zoom,

    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png' AS tile_source;
SELECT 
    'Notre siège'             AS title,
    'indigo'                 AS color,
    '![siège](/x_location_pictures/IMGP7840.JPG)'  AS description_md,
    'map-pin'                                      AS icon,
    orga_dept_latitude::decimal(9,6)               AS latitude,
    orga_dept_longitude::decimal(9,6)               AS longitude
    FROM orga_dept where orga_dept_master = 'master' ;
    




