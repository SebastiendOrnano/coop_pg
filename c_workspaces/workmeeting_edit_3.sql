SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_3.sql') AS properties;

SET user_id = (
    SELECT u.user_id  FROM users as u
    LEFT JOIN (SELECT session_id, user_id, session_token FROM sessions) as s
    ON s.user_id = u.user_id
    WHERE s.session_token = sqlpage.cookie('session_token')
);

SET workspace_id=(SELECT workspace_id FROM workmeetings WHERE workmeeting_id=$workmeeting_id::INTEGER);



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
   'Actualiser la réunion'  AS validate,
    '/c_workspaces/workmeeting_update_0.sql?workmeeting_id='||$workmeeting_id AS action;

SELECT 
    'workmeeting_date'                 AS name,
    'Date de l''évenement'       AS label,
    'date'                       AS type,
    3                            AS width,
    (SELECT workmeeting_date FROM workmeetings WHERE workmeeting_id=$workmeeting_id::INTEGER )  AS value,
    TRUE                        AS required,
   (SELECT regex_value FROM regex WHERE regex_name='date')         AS pattern,
   (SELECT regex_description FROM regex WHERE regex_name='date')          AS description;

SELECT
    'workmeeting_hour_start'           AS name,
    'heure début'                AS label,
    (SELECT workmeeting_hour_start FROM workmeetings WHERE workmeeting_id=$workmeeting_id::INTEGER )  AS value,
    'select'                    AS type, 
    2                        AS width,
    (SELECT project_meeting_hour_start FROM project_meeting WHERE project_meeting_id=$project_meeting_id::INTEGER )  AS value,
    'Choisir une heure dans la liste...'    AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value)ORDER BY i.choice_label ASC)  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='list_hours';

SELECT
    'workmeeting_hour_end'          AS name,
    'heure fin'             AS label,
    (SELECT workmeeting_hour_end FROM workmeetings WHERE workmeeting_id=$workmeeting_id::INTEGER )  AS value,
    'select'                    AS type, 
    2                        AS width,
    (SELECT project_meeting_hour_start FROM project_meeting WHERE project_meeting_id=$project_meeting_id::INTEGER )  AS value,
    'Choisir une heure dans la liste...'    AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value)ORDER BY i.choice_label ASC)  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='list_hours';

SELECT
    'workmeeting_duration'          AS name,
    'durée'                   AS label,
    (SELECT workmeeting_duration FROM workmeetings WHERE workmeeting_id=$workmeeting_id::INTEGER )  AS value,
    'select'                    AS type, 
    2                        AS width,
    (SELECT project_meeting_duration FROM project_meeting WHERE project_meeting_id=$project_meeting_id::INTEGER )  AS value,
    'Choisir une heure dans la liste...'    AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value)ORDER BY i.choice_label ASC)  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='list_hours';

SELECT 
    'workmeeting_alert'      AS name,
    'Alerte'                  AS label,
    'select'                 AS type,
    2                        AS width,
    (SELECT workmeeting_alert FROM workmeetings WHERE workmeeting_id=$workmeeting_id::INTEGER )  AS value,
    'Choisir un statut dans la liste...'    AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='workmeeting_alert';

SELECT
    'workmeeting_title'               AS name,
    'text'                     AS type,  
    'Nom'                      AS label,
    6                           AS width,
    (SELECT workmeeting_title FROM workmeetings WHERE workmeeting_id=$workmeeting_id::INTEGER )  AS value,
    TRUE                       AS required;

SELECT 
    'workmeeting_status'            AS name,
    'Statut'                 AS label,
    'select'                 AS type,
    TRUE                     AS required,
    2                        AS width,
    (SELECT workmeeting_status FROM workmeetings WHERE workmeeting_id=$workmeeting_id::INTEGER )  AS value,
    'Choisir un statut dans la liste...'    AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='status';

SELECT 
    'workmeeting_type'     AS name,
    'Type'                 AS label,
    'select'               AS type,
    2                      AS width,
    (SELECT workmeeting_type FROM workmeetings WHERE workmeeting_id=$workmeeting_id::INTEGER )  AS value,
    'Choisir un type dans la liste...'    AS  empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='meeting_category';

SELECT 
    'workmeeting_visio'      AS name,
    'Présentiel/Visio '      AS label,
    'select'                 AS type,
    TRUE                     AS required,
    2                        AS width,
    (SELECT workmeeting_visio FROM workmeetings WHERE workmeeting_id=$workmeeting_id::INTEGER )  AS value,
    'Choisir  dans la liste...'    AS empty_option,
    '[
    {"label": "Présentiel", "value": "présentiel"},
    {"label": "Visio", "value": "visio"}
    ]'  AS options;

SELECT
    'workmeeting_visio_url'    AS name,
    'text'                     AS type,  
    'URL visio (si visio)'                AS label,
    (SELECT workmeeting_visio_url FROM workmeetings WHERE workmeeting_id=$workmeeting_id::INTEGER )  AS value,
    6                          AS width;

SELECT
    'workmeeting_visio_code'   AS name,
    'text'               AS type,  
    'URL code'           AS label,
    (SELECT workmeeting_visio_code FROM workmeetings WHERE workmeeting_id=$workmeeting_id::INTEGER )  AS value,
    4                   AS width;

SELECT 
    'space_id' AS name,
    'lieu (si présentiel)' AS label,
    'select' AS type,
    12 AS width,
    (SELECT space_id FROM workmeetings WHERE workmeeting_id=$workmeeting_id::INTEGER )  AS value,
    TRUE AS searchable,
   'Saisissez quelques lettres du titre que vous cherchez ou choississez dans la liste' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',
    CASE
    WHEN p.place_name=s.space_name THEN  p.place_name
    ELSE 'Lieu : '||p.place_name||'  -- Salle : '||s.space_name
    END, 
    'value', s.space_id) ORDER BY  p.place_name ASC)  AS options
    FROM place_spaces AS s
    LEFT JOIN place AS p 
    ON p.place_id = s.place_id;

SELECT
    'workmeeting_agenda'             AS name,
    'textarea'                  AS type, 
    (SELECT workmeeting_agenda FROM workmeetings WHERE workmeeting_id=$workmeeting_id::INTEGER )  AS value,
    'Ordre du jour'               AS label;
