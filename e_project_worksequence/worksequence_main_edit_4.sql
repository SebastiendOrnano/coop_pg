SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SET workpackage_id = SELECT workpackage_id FROM project_worksequence WHERE worksequence_id = $worksequence_id::INTEGER;
SET project_id = SELECT project_id FROM project_workpackage WHERE workpackage_id=$workpackage_id::INTEGER;

SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion Superviseur'         AS title,
    '/a_panels/panel_supervisor_4.sql' AS link;
SELECT 
    'Hub project'            AS title,
    '/e_project/project_hub_display_4.sql?project_id='||$project_id     AS link;
SELECT 
    'Lots de travaux'            AS title,
    '/e_project_workpackage/workpackage_hub_display_4.sql?workpackage_id='||$workpackage_id    AS link;   

SELECT 
    'form' AS component,
    'Actualiser les données d''une séquence' AS title,
    'Mettre à jour' AS validate,
    'Clear' AS reset,
    '/e_project_worksequence/worksequence_main_update_0.sql?worksequence_id='||$worksequence_id AS action;

SELECT
    'worksequence_name' AS name,
    'text' AS type,  
    'Nom' AS label,
    6 AS width,
    TRUE AS required,
    (SELECT worksequence_name  FROM project_worksequence WHERE worksequence_id = $worksequence_id::INTEGER ) AS value;

SELECT 
    'worksequence_status'            AS name,
    'Statut'                 AS label,
    'select'                 AS type,
    3 AS width,
    TRUE                     AS required,
    (SELECT worksequence_status  FROM project_worksequence WHERE worksequence_id = $worksequence_id::INTEGER ) AS value,
    'Choisir un stype dans la liste...' AS  empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='status';

SELECT 
    'worksequence_type'            AS name,
    'Statut'                 AS label,
    'select'                 AS type,
    3 AS width,
    (SELECT worksequence_type  FROM project_worksequence WHERE worksequence_id = $worksequence_id::INTEGER ) AS value,
    'Choisir un stype dans la liste...' AS  empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='worksequence_type';


SELECT
    'worksequence_summary' AS name,
    'textarea' AS type,  
    'Description' AS label,
    (SELECT worksequence_summary  FROM project_worksequence WHERE worksequence_id = $worksequence_id::INTEGER ) AS value;

SELECT
    'worksequence_todo' AS name,
    'textarea' AS type,
    'Travaux à faire...' AS description,
    (SELECT worksequence_todo  FROM project_worksequence WHERE worksequence_id = $worksequence_id::INTEGER ) AS value,
    'Travaux à faire' AS label;

SELECT 
    'room_id' AS name,
    'lieu' AS label,
    'select' AS type,
    12 AS width,
    TRUE AS searchable,
    (SELECT room_id FROM project_worksequence WHERE worksequence_id = $worksequence_id::INTEGER ) AS value,
   'Saisissez quelques lettres du titre que vous cherchez ou choississez dans la liste' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',b.building_name||' -- '||r.room_name||' -- '||r.room_type , 'value', r.room_id))  AS options
    FROM project_building_rooms AS r
    LEFT JOIN (SELECT building_id, building_name, project_id FROM project_building)  AS b 
    ON r.building_id = b.building_id
    WHERE b.project_id=$project_id::INTEGER;


SELECT 
    'worksequence_start_date_scheduled' AS name,
    'Date de lancement prévue'       AS label,
    'date'                      AS type,
    6                           AS width,
    (SELECT worksequence_start_date_scheduled  FROM project_worksequence WHERE worksequence_id = $worksequence_id::INTEGER ) AS value,
   (SELECT regex_value FROM regex WHERE regex_name='date')         AS pattern,
   (SELECT regex_description FROM regex WHERE regex_name='date')   AS description;

SELECT 
    'worksequence_start_date_actual' AS name,
    'Date de lancement réelle'       AS label,
    'date'                      AS type,
    6                           AS width,
    (SELECT worksequence_start_date_actual  FROM project_worksequence WHERE worksequence_id = $worksequence_id::INTEGER ) AS value,
   (SELECT regex_value FROM regex WHERE regex_name='date')         AS pattern,
   (SELECT regex_description FROM regex WHERE regex_name='date')   AS description;

SELECT 
    'worksequence_start_hour_scheduled' AS name,
    'Heure de lancement prévue'       AS label,
    'select'                      AS type,
    6                           AS width,
    (SELECT worksequence_start_hour_scheduled::TIME  FROM project_worksequence WHERE worksequence_id = $worksequence_id::INTEGER ) AS value,
    'Choisir une heure dans la liste...'    AS empty_option,
     json_agg(JSON_BUILD_OBJECT('label', i.choice_label, 'value', i.choice_value) ORDER BY i.choice_value) AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE c.choice_category_name='list_hours';

SELECT 
    'worksequence_start_hour_actual' AS name,
    'Heure de lancement réelle'       AS label,
    'select'                     AS type,
    6                           AS width,
    (SELECT worksequence_start_hour_actual  FROM project_worksequence WHERE worksequence_id = $worksequence_id::INTEGER ) AS value,
    'Choisir une heure dans la liste...'    AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label', i.choice_label, 'value', i.choice_value) ORDER BY i.choice_value) AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE c.choice_category_name='list_hours';
 
SELECT 
    'worksequence_end_hour_scheduled' AS name,
    'heure de fin prévue'       AS label,
    'select'                       AS type,
    6                            AS width,
    (SELECT worksequence_end_hour_scheduled FROM project_worksequence WHERE worksequence_id = $worksequence_id::INTEGER ) AS value,
    'Choisir une heure dans la liste...'    AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label', i.choice_label, 'value', i.choice_value) ORDER BY i.choice_value) AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE c.choice_category_name='list_hours';

SELECT 
    'worksequence_end_hour_actual' AS name,
    'Heure de fin réelle'       AS label,
    'select'                      AS type,
    6                          AS width,
    (SELECT worksequence_end_hour_actual  FROM project_worksequence WHERE worksequence_id = $worksequence_id::INTEGER ) AS value,
    'Choisir une heure dans la liste...'    AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label', i.choice_label, 'value', i.choice_value) ORDER BY i.choice_value) AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE c.choice_category_name='list_hours';

SELECT 
    'worksequence_duration_scheduled' AS name,
    'durée prévue'              AS label,
    'select'                      AS type,
    (SELECT worksequence_duration_scheduled  FROM project_worksequence WHERE worksequence_id = $worksequence_id::INTEGER ) AS value,
    'heures'                    AS suffix,
        6                         AS width,
    'Choisir une heure dans la liste...'    AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label', i.choice_label, 'value', i.choice_value) ORDER BY i.choice_value) AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE c.choice_category_name='list_hours';

SELECT 
    'worksequence_duration_actual' AS name,
    'durée réelle'              AS label,
    'select'                      AS type,
    (SELECT worksequence_duration_actual  FROM project_worksequence WHERE worksequence_id = $worksequence_id::INTEGER ) AS value,
    'heures'                    AS suffix,
    'durée en heures'  AS description,
    6                         AS width,
        'Choisir une heure dans la liste...'    AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label', i.choice_label, 'value', i.choice_value) ORDER BY i.choice_value) AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE c.choice_category_name='list_hours';

SELECT 
    'worksequence_completion_percentage'           AS name,
    'Pourcentage d''achèvement'              AS label,
    (SELECT worksequence_completion_percentage  FROM project_worksequence WHERE worksequence_id = $worksequence_id::INTEGER ) AS value,   
    'number'                                 AS type,
    '%'                                      AS suffix,
    4                          AS width;
