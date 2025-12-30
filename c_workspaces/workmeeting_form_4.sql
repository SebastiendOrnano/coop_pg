SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion Éditeur'         AS title,
     '/a_panels/panel_editor_4.sql' AS link;
SELECT 
    'Liste des espaces de travail'            AS title,
    '/c_workspaces/workspace_main_display_4.sql' AS link;
SELECT 
    'Retour à l''espace de travail'            AS title,
    '/c_workspaces/workspace_hub_display_4.sql?workspace_id='||$workspace_id AS link;

SELECT 
    'form'                                AS component,
    'Créer un événement'                  AS title,
    'Créer'                               AS validate,
    'Clear'                               AS reset,
    '/c_workspaces/workmeeting_create_0.sql?workspace_id='||$workspace_id AS action;

SELECT
    'workmeeting_title'               AS name,
    'text'                     AS type,  
    'Nom'                      AS label,
    6                           AS width,
    TRUE                       AS required;

SELECT 
    'workmeeting_status'            AS name,
    'Statut'                 AS label,
    'select'                 AS type,
    TRUE                     AS required,
    2                        AS width,
    'Choisir un statut dans la liste...'    AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='status';

SELECT 
    'workmeeting_type'            AS name,
    'Type'                 AS label,
    'select'               AS type,
    2                     AS width,
    'Choisir un type dans la liste...'    AS  empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='meeting_category';

SELECT 
    'workmeeting_visio'            AS name,
    'Présentiel/Visio '     AS label,
    'select'                 AS type,
    TRUE                     AS required,
    2                        AS width,
    'Choisir  dans la liste...'    AS empty_option,
    '[
    {"label": "Présentiel", "value": "présentiel"},
    {"label": "Visio", "value": "visio"}
    ]'  AS options;

SELECT
    'workmeeting_visio_url'          AS name,
    'text'                     AS type,  
    'URL visio'                AS label,
    6                          AS width;

SELECT
    'workmeeting_visio_code'   AS name,
    'text'               AS type,  
    'URL code'           AS label,
    4                   AS width;

SELECT 
    'space_id' AS name,
    'lieu' AS label,
    'select' AS type,
    12 AS width,
    TRUE AS searchable,
   'Saisissez quelques lettres du titre que vous cherchez ou choississez dans la liste' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',
    CASE
    WHEN p.place_name=s.space_name THEN  p.place_name
    ELSE 'Lieu : '||p.place_name||'  -- Salle : '||s.space_name
    END, 
    'value', s.space_id)ORDER BY  p.place_name ASC)  AS options
    FROM place_spaces AS s
    LEFT JOIN place AS p 
    ON p.place_id = s.place_id;

SELECT
    'workmeeting_agenda'             AS name,
    'textarea'                  AS type,  
    'Ordre du jour'               AS label;

SELECT 
    'workmeeting_date'                 AS name,
    'Date de l''évenement'       AS label,
    'date'                       AS type,
    3                            AS width,
    TRUE                        AS required,
   (SELECT regex_value FROM regex WHERE regex_name='date')         AS pattern,
   (SELECT regex_description FROM regex WHERE regex_name='date')          AS description;

SELECT
    'workmeeting_hour_start'           AS name, 
    'heure début'                AS label,
    'select'                    AS type, 
    2                        AS width,
    'Choisir une heure dans la liste...'    AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value)ORDER BY i.choice_label ASC)  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='list_hours';

SELECT
    'workmeeting_hour_end'          AS name,
    'heure fin'             AS label,
    'select'                    AS type, 
    2                        AS width,
    'Choisir une heure dans la liste...'    AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value)ORDER BY i.choice_label ASC)  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='list_hours';

SELECT
    'workmeeting_duration'          AS name,
    'durée'                   AS label,
    'select'                    AS type, 
    2                        AS width,
    'Choisir une heure dans la liste...'    AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value)ORDER BY i.choice_label ASC)  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='list_hours';