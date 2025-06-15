SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_3.sql') AS properties;

SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion éditeur'         AS title,
    '/a_panels/panel_editor_3.sql' AS link;
SELECT 
    'Retour liste des événements'            AS title,
    '/b_events/event_main_display_3.sql'     AS link;


SELECT 
    'form'                              AS component,
    'Actualiser un événement'            AS title,
    'Actualiser'                         AS validate,
    'Clear'                              AS reset,
    '/b_events/event_main_update_0.sql?event_id='||$event_id AS action;

SELECT
    'event_name' AS name,
    'text' AS type,  
    'Nom' AS label,
    (SELECT event_name FROM events WHERE event_id=$event_id::INTEGER ) AS value,
    6 AS width,
    TRUE AS required;

SELECT 
    'event_public_private'   AS name,
    'Public/privé'           AS label,
    'select'                 AS type,
    (SELECT event_public_private FROM events WHERE event_id=$event_id::INTEGER ) AS value,
    TRUE                     AS required,
    2                        AS width,
    'Choisir un statut dans la liste...'    AS empty_option,
    '[
    {"label": "Public", "value": "public"},
    {"label": "Privé", "value": "private"}
    ]'  AS options;

SELECT 
    'event_status'            AS name,
    'Statut'                 AS label,
    'select'                 AS type,
    (SELECT event_status FROM events WHERE event_id=$event_id::INTEGER ) AS value,
    TRUE                     AS required,
    2                        AS width,
    'Choisir un statut dans la liste...'    AS empty_option,
    'Choisir un statut dans la liste...'    AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='status';


SELECT 
    'event_type'                 AS name,
    'Type'                       AS label,
    'select'                     AS type,
    2                           AS width,
    (SELECT event_type FROM events WHERE event_id=$event_id::INTEGER ) AS value,
    'Choisir un type dans la liste...'    AS  empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='event';

SELECT 
    'event_visio'            AS name,
    'Présentiel/Visio '     AS label,
    'select'                 AS type,
    TRUE                     AS required,
    2                        AS width,
    (SELECT event_visio FROM events WHERE event_id=$event_id::INTEGER ) AS value,
    'Choisir  dans la liste...'    AS empty_option,
    '[
    {"label": "Présentiel", "value": "face-to-face"},
    {"label": "Visio", "value": "visio"}
    ]'  AS options;

SELECT
    'event_visio_url'          AS name,
    'text'                     AS type,
    (SELECT event_visio_url FROM events WHERE event_id=$event_id::INTEGER ) AS value,  
    'URL visio'                AS label,
    6                          AS width;

SELECT
    'event_visio_code'   AS name,
    'text'               AS type,  
    'URL code'           AS label,
    (SELECT event_visio_code FROM events WHERE event_id=$event_id::INTEGER ) AS value, 
    4                   AS width;

SELECT 
    'space_id' AS name,
    'lieu' AS label,
    'select' AS type,
    12 AS width,
    (SELECT space_id FROM events WHERE event_id=$event_id::INTEGER ) AS value, 
    TRUE AS searchable,
   'Saisissez quelques lettres du titre que vous cherchez ou choississez dans la liste' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label', p.place_name||'('||p.place_id||')--'||s.space_name||'('||s.space_id ||')', 'value', s.space_id)ORDER BY  s.space_id ASC) AS options
    FROM place_spaces AS s
    LEFT JOIN place AS p ON p.place_id = s.place_id;


SELECT
    'event_summary' AS name,
    'textarea' AS type, 
    (SELECT event_summary FROM events WHERE event_id=$event_id::INTEGER ) AS value, 
    'Description' AS label;

SELECT
    'file'                  AS type, 
    'event_program_url'          AS name,
    'Programme'    AS label,
    'format : pdf, jpeg',
    'image/*' AS accept;

SELECT
    'file'                  AS type, 
    'event_picture_url'          AS name,
    'Illustration'    AS label,
    'format : pdf, png, jpg, jpeg',
    'image/*' AS accept;


SELECT 
    'event_date' AS name,
    'Date de l''évenement'       AS label,
    'date'                      AS type,
    3                            AS width,
    (SELECT event_date FROM events WHERE event_id=$event_id::INTEGER ) AS value,
   (SELECT regex_value FROM regex WHERE regex_name='date')         AS pattern,
   (SELECT regex_description FROM regex WHERE regex_name='date')   AS description;


SELECT
    'event_start_hour' AS name,
    'select' AS type,  
    'heure début' AS label,
    3 AS width,
    (SELECT event_start_hour FROM events WHERE event_id=$event_id::INTEGER ) AS value,
    'Choisir une heure dans la liste...'    AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value)ORDER BY i.choice_label ASC)  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='list_hours';

SELECT
    'event_end_hour' AS name,
    'select' AS type,  
    'heure fin' AS label,
    (SELECT event_end_hour FROM events WHERE event_id=$event_id::INTEGER ) AS value,
    3 AS width,
    'Choisir une heure dans la liste...'    AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value)ORDER BY i.choice_label ASC)  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='list_hours';

SELECT
    'event_duration' AS name,
    'select' AS type,  
    'durée' AS label,
    (SELECT event_duration FROM events WHERE event_id=$event_id::INTEGER ) AS value,
    3 AS width,
    'Choisir une heure dans la liste...'    AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value)ORDER BY i.choice_label ASC)  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='list_hours';

SELECT
    'event_audience_target' AS name,
    'text' AS type,  
    'Public cible' AS label,
    (SELECT event_audience_target FROM events WHERE event_id=$event_id::INTEGER ) AS value,
    6 AS width;

SELECT
    'event_participants_nb_max' AS name,
    'number' AS type,  
    'Nb max' AS label,
    (SELECT event_participants_nb_max FROM events WHERE event_id=$event_id::INTEGER ) AS value,
    'participants' AS suffix,
    3 AS width;

SELECT 
    'event_registration'     AS name,
    'Inscription'                 AS label,
    'select'                 AS type,
    (SELECT event_registration FROM events WHERE event_id=$event_id::INTEGER ) AS value,
    TRUE                     AS required,
    3                        AS width,
    'Choisir un statut dans la liste...'    AS empty_option,
    '[
    {"label": "Inscription obligatoire", "value": true},
    {"label": "Entrée libre", "value": false}
    ]'  AS options;

SELECT
    'event_entrance_fee' AS name,
    'number' AS type,  
    'Prix d''entrée' AS label,
    (SELECT event_entrance_fee FROM events WHERE event_id=$event_id::INTEGER ) AS value,
    'euros' AS suffix,
    3 AS width;