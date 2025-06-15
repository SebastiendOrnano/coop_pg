SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_3.sql') AS properties;

SET user_id = (
    SELECT users.user_id  FROM users
    INNER JOIN sessions ON users.user_id = sessions.user_id
    WHERE sessions.session_token = sqlpage.cookie('session_token')
); 


SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion éditeur'         AS title,
    '/a_panels/panel_editor_3.sql' AS link;
 SELECT 
    'Retour à la liste des projets'            AS title,
    '/e_project/project_main_display_3.sql'     AS link;   
 SELECT 
    'Retour au hub du projet'            AS title,
    '/e_project/project_hub_display_3.sql?project_id='||$project_id     AS link;
SELECT 
    'Retour à la liste des réunions'            AS title,
    '/e_project_meeting/project_meeting_main_display_3.sql?project_id='||$project_id     AS link;



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
   'Actualiser la réunion' AS validate,
    '/e_project_meeting/project_meeting_main_update_0.sql?project_meeting_id='||$project_meeting_id AS action;

SELECT 
    'project_meeting_date'                 AS name,
    'Date de l''évenement'       AS label,
    'date'                       AS type,
    3                            AS width,
    (SELECT project_meeting_date FROM project_meeting WHERE project_meeting_id=$project_meeting_id::INTEGER )  AS value,
    TRUE                        AS required,
    (SELECT regex_value FROM regex WHERE regex_name='date')         AS pattern,
   (SELECT regex_description FROM regex WHERE regex_name='date')          AS description;

SELECT
    'project_meeting_hour_start'           AS name,
    'select'                    AS type, 
    2                        AS width,
    'heure début'                AS label,
    (SELECT project_meeting_hour_start FROM project_meeting WHERE project_meeting_id=$project_meeting_id::INTEGER )  AS value,
    'Choisir une heure dans la liste...'    AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value)ORDER BY i.choice_label ASC)  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='list_hours';


SELECT
    'project_meeting_hour_end'          AS name,
    'select'                    AS type, 
    2                        AS width,
    'heure fin'             AS label,
    (SELECT project_meeting_hour_end FROM project_meeting WHERE project_meeting_id=$project_meeting_id::INTEGER )  AS value,
    'Choisir une heure dans la liste...'    AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value)ORDER BY i.choice_label ASC)  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='list_hours';

SELECT
    'project_meeting_duration'  AS name,
    'select'                    AS type,  
    2                           AS width,
    'durée'                     AS label,
    (SELECT project_meeting_duration FROM project_meeting WHERE project_meeting_id=$project_meeting_id::INTEGER )  AS value,
    'Choisir une heure dans la liste...'    AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value)ORDER BY i.choice_label ASC)  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='list_hours';
SELECT 
    'project_meeting_alert'      AS name,
    'Alerte'                  AS label,
    'select'                 AS type,
    2                        AS width,
    (SELECT project_meeting_alert FROM project_meeting WHERE project_meeting_id=$project_meeting_id::INTEGER )  AS value,
    'Choisir un statut dans la liste...'    AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='workmeeting_alert';

SELECT
    'project_meeting_title'               AS name,
    'text'                     AS type,  
    'Nom'                      AS label,
    6                           AS width,
    (SELECT project_meeting_title FROM project_meeting WHERE project_meeting_id=$project_meeting_id::INTEGER )  AS value,
    TRUE                       AS required;

SELECT 
    'project_meeting_status'            AS name,
    'Statut'                 AS label,
    'select'                 AS type,
    TRUE                     AS required,
    2                        AS width,
    (SELECT project_meeting_status FROM project_meeting WHERE project_meeting_id=$project_meeting_id::INTEGER )  AS value,
    'Choisir un statut dans la liste...'    AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='status';

SELECT 
    'project_meeting_type'     AS name,
    'Type'                 AS label,
    'select'               AS type,
    2                      AS width,
    (SELECT project_meeting_type FROM project_meeting WHERE project_meeting_id=$project_meeting_id::INTEGER )  AS value,
    'Choisir un type dans la liste...'    AS  empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='meeting_category';

SELECT 
    'project_meeting_visio'      AS name,
    'Présentiel/Visio '      AS label,
    'select'                 AS type,
    TRUE                     AS required,
    2                        AS width,
    (SELECT project_meeting_visio FROM project_meeting WHERE project_meeting_id=$project_meeting_id::INTEGER )  AS value,
    'Choisir  dans la liste...'    AS empty_option,
    '[
    {"label": "Présentiel", "value": false},
    {"label": "Visio", "value": true}
    ]'  AS options;

SELECT
    'project_meeting_visio_url'    AS name,
    'text'                     AS type,  
    'URL visio (si visio)'                AS label,
    (SELECT project_meeting_visio_url FROM project_meeting WHERE project_meeting_id=$project_meeting_id::INTEGER )  AS value,
    6                          AS width;

SELECT
    'project_meeting_visio_code'   AS name,
    'text'               AS type,  
    'URL code'           AS label,
    (SELECT project_meeting_visio_code FROM project_meeting WHERE project_meeting_id=$project_meeting_id::INTEGER )  AS value,
    4                   AS width;

SELECT 
    'project_meeting_place_id' AS name,
    'lieu (si présentiel)' AS label,
    'select' AS type,
    12 AS width,
    (SELECT project_meeting_place_id FROM project_meeting WHERE project_meeting_id=$project_meeting_id::INTEGER )  AS value,
    TRUE AS searchable,
   'Saisissez quelques lettres du titre que vous cherchez ou choississez dans la liste' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',project_meeting_place_name,'value', project_meeting_place_id))  AS options
    FROM project_meeting_places;;

SELECT
    'project_meeting_agenda'             AS name,
    'textarea'                  AS type, 
    (SELECT project_meeting_agenda FROM project_meeting WHERE project_meeting_id=$project_meeting_id::INTEGER )  AS value,
    'Ordre du jour'               AS label;

