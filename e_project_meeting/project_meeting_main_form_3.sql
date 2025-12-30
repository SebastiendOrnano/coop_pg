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
    'Retour à la liste des projets'            AS title,
    '/e_project/project_main_display_3.sql'     AS link;   
 SELECT 
    'Retour au hub du projet'            AS title,
    '/e_project/project_hub_display_3.sql?project_id='||$project_id     AS link;
SELECT 
    'Retour à la liste des réunions'            AS title,
    '/e_project_meeting/project_meeting_main_display_3.sql?project_id='||$project_id     AS link;

SELECT 
    'form'                                AS component,
    'Créer un événement'                  AS title,
    'Créer'                               AS validate,
    'Clear'                               AS reset,
    '/e_project_meeting/project_meeting_main_create_0.sql?project_id='||$project_id AS action;

SELECT
    'project_meeting_title'               AS name,
    'text'                     AS type,  
    'Nom'                      AS label,
    6                           AS width,
    TRUE                       AS required;

SELECT 
    'project_meeting_status'            AS name,
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
    'project_meeting_type'            AS name,
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
    'project_meeting_visio'            AS name,
    'Présentiel/Visio '     AS label,
    'select'                 AS type,
    TRUE                     AS required,
    2                        AS width,
    'Choisir  dans la liste...'    AS empty_option,
    '[
    {"label": "Présentiel", "value": "face-to-face"},
    {"label": "Visio", "value": "visio"}
    ]'  AS options;

SELECT
    'project_meeting_visio_url'          AS name,
    'text'                     AS type,  
    'URL visio'                AS label,
    6                          AS width;

SELECT
    'project_meeting_visio_code'   AS name,
    'text'               AS type,  
    'URL code'           AS label,
    4                   AS width;

SELECT 
    'project_meeting_place_id' AS name,
    'lieu' AS label,
    'select' AS type,
    12 AS width,
    TRUE AS searchable,
   'Saisissez quelques lettres du titre que vous cherchez ou choississez dans la liste' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',project_meeting_place_name,'value', project_meeting_place_id))  AS options
    FROM project_meeting_places;;

SELECT
    'project_meeting_agenda'             AS name,
    'textarea'                  AS type,  
    'Ordre du jour'               AS label;

SELECT 
    'project_meeting_date'                 AS name,
    'Date de l''évenement'       AS label,
    'date'                       AS type,
    3                            AS width,
    TRUE                        AS required,
   (SELECT regex_value FROM regex WHERE regex_name='date')         AS pattern,
   (SELECT regex_description FROM regex WHERE regex_name='date')          AS description;

SELECT
    'project_meeting_hour_start'           AS name,
    'select'                       AS type,  
    'heure début'                AS label,

    2                            AS width,
    'Choisir une heure dans la liste...'    AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value)ORDER BY i.choice_label ASC)  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='list_hours';

SELECT
    'project_meeting_hour_end'          AS name,
    'select'                    AS type,  
    'heure fin'             AS label,
    2                        AS width,
        'Choisir une heure dans la liste...'    AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value)ORDER BY i.choice_label ASC)  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='list_hours';

SELECT
    'project_meeting_duration'          AS name,
    'select'                    AS type,  
    2                         AS width,
    'Choisir une heure dans la liste...'    AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value)ORDER BY i.choice_label ASC)  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='list_hours';