SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_3.sql') AS properties;

SET user_id = (
    SELECT u.user_id  FROM users as u
    LEFT JOIN (SELECT session_id, user_id, session_token FROM sessions) as s
    ON s.user_id = u.user_id
    WHERE s.session_token = sqlpage.cookie('session_token')
);

SET workspace_id=(SELECT workspace_id FROM workmeetings WHERE workmeeting_id=$workmeeting_id::INTEGER);

SET coordinator = 
CASE
WHEN (SELECT user_id FROM workmeeting_participants WHERE workmeeting_participant_role='coordinator' AND workmeeting_id=$workmeeting_id::INTEGER)= $user_id::INTEGER 
THEN 'coordinator'
ELSE ''
END;

SET space_id = SELECT space_id FROM workmeetings WHERE workmeeting_id =$workmeeting_id::INTEGER;

SELECT
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion éditeur'         AS title,
    '/a_panels/panel_editor_3.sql' AS link;
SELECT 
     '/c_workspaces/workspace_main_display_3.sql'             AS link,
    'Espaces de travail'           AS title;
SELECT 
    '/c_workspaces/workspace_hub_display_3.sql?workspace_id='||$workspace_id  AS link,
    'Espace du groupe de travail'                                      AS title;


SELECT 
    'divider'                             AS component,
    'Description de la réunion' AS contents,
    'left'                                AS position,
    'black'                               AS color;

SET lieu = (
    SELECT s.space_name
    FROM workmeetings e
    LEFT JOIN place_spaces s ON s.space_id = e.space_id
    WHERE e.workmeeting_id = $workmeeting_id::INTEGER
    );

SET adress = (
    SELECT CONCAT(p.place_adress, '       
', p.place_postal_code, '     ', p.place_town)
    FROM workmeetings as e
    LEFT JOIN (SELECT space_id, place_id FROM place_spaces) as s 
    ON s.space_id = e.space_id
    LEFT JOIN (SELECT place_id, place_adress, place_postal_code, place_town FROM place) as p
    ON p.place_id = s.place_id
    WHERE e.workmeeting_id = $workmeeting_id::INTEGER
);

SET place_id = SELECT p.place_id 
    FROM workmeetings as e
    LEFT JOIN (SELECT space_id, place_id FROM place_spaces) as s 
    ON s.space_id = e.space_id
    LEFT JOIN (SELECT place_id FROM place) as p
    ON p.place_id = s.place_id
    WHERE e.workmeeting_id = $workmeeting_id::INTEGER;

SELECT 
    'form' AS component,
    ''  AS validate;

SELECT 
    'workmeeting_date'                 AS name,
    'Date de l''évenement'       AS label,
    'date'                       AS type,
    3                            AS width,
    TRUE AS readonly,
    (SELECT workmeeting_date FROM workmeetings WHERE workmeeting_id=$workmeeting_id::INTEGER )  AS value;

SELECT
    'workmeeting_hour_start'           AS name,
    'text'                       AS type,  
    'heure début'                AS label,
    TRUE AS readonly,
    (SELECT workmeeting_hour_start FROM workmeetings WHERE workmeeting_id=$workmeeting_id::INTEGER )  AS value,
    2                            AS width;

SELECT
    'workmeeting_hour_end'          AS name,
    'text'                    AS type,  
    'heure fin'             AS label,
    TRUE AS readonly,
    (SELECT workmeeting_hour_end FROM workmeetings WHERE workmeeting_id=$workmeeting_id::INTEGER )  AS value,
    2                        AS width;

SELECT
    'workmeeting_duration'          AS name,
    'text'                    AS type,  
    'durée'                   AS label,
    TRUE AS readonly,
    (SELECT workmeeting_duration FROM workmeetings WHERE workmeeting_id=$workmeeting_id::INTEGER )  AS value,
    2                         AS width;

SELECT 
    'workmeeting_alert'      AS name,
    'Alerte'                  AS label,
    'text'                 AS type,
    2                        AS width,
    TRUE AS readonly;

SELECT
    'workmeeting_title'               AS name,
    'text'                     AS type,  
    'Nom'                      AS label,
    6                           AS width,
    TRUE AS readonly,
    (SELECT workmeeting_title FROM workmeetings WHERE workmeeting_id=$workmeeting_id::INTEGER )  AS value;

SELECT 
    'workmeeting_status'            AS name,
    'Statut'                 AS label,
    'text'                 AS type,
    2                        AS width,
    (SELECT workmeeting_status FROM workmeetings WHERE workmeeting_id=$workmeeting_id::INTEGER )  AS value,
    TRUE AS readonly;

SELECT 
    'workmeeting_type'     AS name,
    'Type'                 AS label,
    'text'               AS type,
    2                      AS width,
    (SELECT workmeeting_type FROM workmeetings WHERE workmeeting_id=$workmeeting_id::INTEGER )  AS value,
    TRUE AS readonly;

SELECT 
    'workmeeting_visio'      AS name,
    'Présentiel/Visio '      AS label,
    'text'                 AS type,
    (SELECT workmeeting_visio FROM workmeetings WHERE workmeeting_id=$workmeeting_id::INTEGER )  AS value,
    2                        AS width,
    TRUE AS readonly;

SELECT
    'workmeeting_visio_url'    AS name,
    'text'                     AS type,  
    'URL visio (si visio)'                AS label,
    TRUE AS readonly,
    (SELECT workmeeting_visio_url FROM workmeetings WHERE workmeeting_id=$workmeeting_id::INTEGER )  AS value,
    6                          AS width;

SELECT
    'workmeeting_visio_code'   AS name,
    'text'               AS type,  
    'URL code'           AS label,
    TRUE AS readonly,
    (SELECT workmeeting_visio_code FROM workmeetings WHERE workmeeting_id=$workmeeting_id::INTEGER )  AS value,
    4                   AS width;

SELECT 
    'space_id' AS name,
    'lieu (si présentiel)' AS label,
    'text' AS type,
    TRUE AS readonly,
    12 AS width,
    (SELECT space_name FROM place_spaces WHERE space_id=$space_id::INTEGER )  AS value;

SELECT
    'workmeeting_agenda'             AS name,
    'textarea'                  AS type, 
    TRUE AS readonly,
    (SELECT workmeeting_agenda FROM workmeetings WHERE workmeeting_id=$workmeeting_id::INTEGER )  AS value,
    'Ordre du jour'               AS label;

SELECT 
    'divider'                             AS component,
    'Liste des participants à la réunion' AS contents,
    'left'                                AS position,
    'black'                               AS color;

SELECT 
    'button'                                   AS component,
    TRUE                                       AS important,
    'sm'                                       AS size;
SELECT 
    '/c_workspaces/workmeeting_join_0.sql?workmeeting_id='||$workmeeting_id    AS link,
    'green'                                     AS color,
    'S''inscrire'                                AS title,
    'copy-plus'                                  AS icon;

SELECT 
    '/c_workspaces/workmeeting_quit_0.sql?workmeeting_id='||$workmeeting_id    AS link,
    'red'                                    AS color,
    'Se désincrire'          AS title,
    'copy-plus'                                  AS icon;

-- Display list of organizations
SELECT 'table' AS component, 
    'Liste des participants'   AS title, 
    'View'           AS markdown;

SELECT
    p.workmeeting_participant_id                    AS Id,
    u.user_first_name                               AS Prénom,
    u.user_last_name                                AS Nom,
    u.user_email                                    AS Mail
FROM workmeeting_participants AS p
LEFT JOIN 
(SELECT user_id, user_first_name, user_last_name, user_email FROM users ) AS u
ON p.user_id = u.user_id
WHERE p.workmeeting_id=$workmeeting_id::INTEGER
ORDER BY created_at ASC;
