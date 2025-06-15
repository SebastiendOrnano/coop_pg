SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_3.sql') AS properties;

SET project_id = SELECT project_id FROM project_workpackage WHERE workpackage_id=$workpackage_id::INTEGER;

SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion éditeur'         AS title,
    '/a_panels/panel_editor_3.sql' AS link;
SELECT 
    'Projets'            AS title,
    '/e_project/project_main_display_3.sql'   AS link;   
 SELECT 
    'Hub projet'            AS title,
    '/e_project/project_hub_display_3.sql?project_id='||$project_id     AS link;   
SELECT 
    'Hub lot de travaux'            AS title,
    '/e_project_workpackage/workpackage_hub_display_3.sql?workpackage_id='||$workpackage_id    AS link;

SELECT 
    'form' AS component,
    'Créer un séquence' AS title,
    'Créer' AS validate,
    'Clear' AS reset,
    '/e_project_worksequence/worksequence_main_create_0.sql?workpackage_id='||$workpackage_id AS action;

SELECT
    'worksequence_name' AS name,
    'text' AS type,  
    'Nom' AS label,
    8 AS width,
    TRUE AS required;

SELECT 
    'worksequence_type'            AS name,
    'Type de sequence'                 AS label,
    'select'                 AS type,
    4 AS width,
    'Choisir un type dans la liste...' AS  empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='worksequence_type';

SELECT
    'worksequence_summary' AS name,
    'textarea' AS type,
    'Présentation du séquence' AS label;

SELECT
    'worksequence_todo' AS name,
    'textarea' AS type,
    'Travaux à faire...' AS description,
    'Travaux à faire' AS label;

SELECT 
    'room_id' AS name,
    'lieu' AS label,
    'select' AS type,
    12 AS width,
    TRUE AS searchable,
   'Saisissez quelques lettres du titre que vous cherchez ou choississez dans la liste' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',b.building_name||' -- '||r.room_name||' -- '||r.room_type , 'value', r.room_id))  AS options
    FROM project_building_rooms AS r
    LEFT JOIN (SELECT building_id, building_name, project_id FROM project_building)  AS b 
    ON r.building_id = b.building_id
    WHERE b.project_id=$project_id::INTEGER
    ;

SELECT 
    'worksequence_start_date_scheduled' AS name,
    'Date de lancement prévue'          AS label,
    'date'                              AS type,
    3                                   AS width,
    TRUE                                AS required,
   (SELECT regex_value FROM regex WHERE regex_name='date')                AS pattern,
   (SELECT regex_description FROM regex WHERE regex_name='date')          AS description;

SELECT 
    'worksequence_start_hour_scheduled' AS name,
    'Heure de début de la séquence'       AS label,
    'select'                      AS type,
    3                            AS width,
    'Choisir une heure dans la liste...'    AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label', i.choice_label, 'value', i.choice_value) ORDER BY i.choice_value) AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='list_hours';

SELECT 
    'worksequence_end_hour_scheduled' AS name,
    'Heure de fin de la séquence'       AS label,
    'select'                      AS type,
    3                            AS width,
    'Choisir une heure dans la liste...'    AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label', i.choice_label, 'value', i.choice_value) ORDER BY i.choice_value) AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='list_hours';

SELECT 
    'worksequence_duration_scheduled' AS name,
    'durée'              AS label,
    'select'                      AS type,
    'heures'                    AS suffix,
    'durée en heures'  AS description,
    3                          AS width,
    'Choisir une heure dans la liste...'    AS empty_option,
     json_agg(JSON_BUILD_OBJECT('label', i.choice_label, 'value', i.choice_value) ORDER BY i.choice_value) AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='list_hours';
