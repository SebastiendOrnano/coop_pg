SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SET project_id = SELECT project_id FROM project_meeting WHERE project_meeting_id=$project_meeting_id::INTEGER;

SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion Superviseur'         AS title,
    '/a_panels/panel_supervisor_4.sql' AS link;
 SELECT 
    'Retour à la liste des projets'            AS title,
    '/e_project/project_main_display_4.sql'     AS link;   
 SELECT 
    'Retour au hub du projet'            AS title,
    '/e_project/project_hub_display_4.sql?project_id='||$project_id     AS link;
SELECT 
    'Retour à la liste des réunions'            AS title,
    '/e_project_meeting/project_meeting_main_display_4.sql?project_id='||$project_id     AS link;

SELECT 
    'divider'                             AS component,
    'Description de la réunion' AS contents,
    'left'                                AS position,
    'black'                               AS color;

SET lieu = (
    SELECT p.project_meeting_place_name
FROM project_meeting_places AS p
LEFT JOIN project_meeting AS m
ON p.project_meeting_place_id = m.project_meeting_place_id
WHERE m.project_id = $project_id::INTEGER
);

SET adress = (
    SELECT CONCAT(p.project_meeting_place_adress, '       
', p.project_meeting_place_postal_code, '     ', p.project_meeting_place_town)
    FROM project_meeting AS m
    LEFT JOIN (SELECT project_meeting_place_id, project_meeting_place_adress, project_meeting_place_postal_code, project_meeting_place_town  FROM project_meeting_places) AS p 
    ON p.project_meeting_place_id = m.project_meeting_place_id
    WHERE m.project_meeting_id = $project_meeting_id::INTEGER
);

SELECT 
    'form' AS component,
    '' validate;

SELECT 
    'project_meeting_date'                 AS name,
    'Date de l''évenement'       AS label,
    'date'                       AS type,
    3                            AS width,
    TRUE                         AS readonly,
    (SELECT project_meeting_date FROM project_meeting WHERE project_meeting_id=$project_meeting_id::INTEGER )  AS value;
SELECT
    'project_meeting_hour_start'           AS name,
    'text'                       AS type,  
    'heure début'                AS label,
    TRUE                         AS readonly,
    (SELECT project_meeting_hour_start FROM project_meeting WHERE project_meeting_id=$project_meeting_id::INTEGER )  AS value,
    2                            AS width;

SELECT
    'project_meeting_hour_end'          AS name,
    'text'                    AS type,  
    'heure fin'             AS label,
    TRUE                         AS readonly,
    (SELECT project_meeting_hour_end FROM project_meeting WHERE project_meeting_id=$project_meeting_id::INTEGER )  AS value,
    2                        AS width;

SELECT
    'project_meeting_duration'          AS name,
    'text'                    AS type,  
    'durée'                   AS label,
    TRUE                         AS readonly,
    (SELECT project_meeting_duration FROM project_meeting WHERE project_meeting_id=$project_meeting_id::INTEGER )  AS value,
    2                         AS width;

SELECT 
    'project_meeting_alert'      AS name,
    'Alerte'                  AS label,
    'text'                AS type,
    2                        AS width,
    TRUE                         AS readonly,
    (SELECT project_meeting_alert FROM project_meeting WHERE project_meeting_id=$project_meeting_id::INTEGER )  AS value;

SELECT
    'project_meeting_title'               AS name,
    'text'                     AS type,  
    'Nom'                      AS label,
    6                           AS width,
    TRUE                         AS readonly,
    (SELECT project_meeting_title FROM project_meeting WHERE project_meeting_id=$project_meeting_id::INTEGER )  AS value,
    TRUE                       AS required;

SELECT 
    'project_meeting_status'            AS name,
    'Statut'                 AS label,
    'text'                AS type,
    TRUE                     AS required,
    2                        AS width,
    TRUE                         AS readonly,
    (SELECT project_meeting_status FROM project_meeting WHERE project_meeting_id=$project_meeting_id::INTEGER )  AS value;
SELECT 
    'project_meeting_type'     AS name,
    'Type'                 AS label,
    'text'               AS type,
    2                      AS width,
    TRUE                         AS readonly,
    (SELECT project_meeting_type FROM project_meeting WHERE project_meeting_id=$project_meeting_id::INTEGER )  AS value;

SELECT 
    'project_meeting_visio'      AS name,
    'Présentiel/Visio '      AS label,
    'text'                 AS type,
    TRUE                     AS required,
    2                        AS width,
    TRUE                         AS readonly,
    (SELECT project_meeting_visio FROM project_meeting WHERE project_meeting_id=$project_meeting_id::INTEGER )  AS value;

SELECT
    'project_meeting_visio_url'    AS name,
    'text'                     AS type,  
    'URL visio (si visio)'                AS label,
    TRUE                         AS readonly,
    (SELECT project_meeting_visio_url FROM project_meeting WHERE project_meeting_id=$project_meeting_id::INTEGER )  AS value,
    6                          AS width;

SELECT
    'project_meeting_visio_code'   AS name,
    'text'               AS type,  
    'URL code'           AS label,
    TRUE                         AS readonly,
    (SELECT project_meeting_visio_code FROM project_meeting WHERE project_meeting_id=$project_meeting_id::INTEGER )  AS value,
    4                   AS width;

SELECT 
    'project_meeting_place_id'   AS name,
    'lieu (si présentiel)'        AS label,
    'text'                        AS type,
    TRUE                         AS readonly,
    12 AS width,
    (SELECT project_meeting_place_id FROM project_meeting WHERE project_meeting_id=$project_meeting_id::INTEGER )  AS value;

SELECT
    'project_meeting_agenda'             AS name,
    'textarea'                  AS type, 
    TRUE                         AS readonly,
    (SELECT project_meeting_agenda FROM project_meeting WHERE project_meeting_id=$project_meeting_id::INTEGER )  AS value,
    'Ordre du jour'               AS label;

