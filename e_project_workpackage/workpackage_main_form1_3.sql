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
    'Projets'            AS title,
    '/e_project/project_main_display_3.sql'   AS link;   
 SELECT 
    'Hub projet'            AS title,
    '/e_project/project_hub_display_3.sql?project_id='||$project_id     AS link;   

SELECT 
    'form' AS component,
    'Créer un workpackage' AS title,
    'Créer' AS validate,
    'Clear' AS reset,
    '/e_project_workpackage/workpackage_main_create1_0.sql?project_id='||$project_id AS action;

SELECT
    'workpackage_name' AS name,
    'text' AS type,  
    'Nom' AS label,
    12 AS width,
    TRUE AS required;
SELECT
    'workpackage_summary' AS name,
    'textarea' AS type,
    'Présentation du workpackage' AS label;

SELECT
    'workpackage_todo' AS name,
    'textarea' AS type,
    'Travaux à faire...' AS description,
    'Travaux à faire' AS label;

SELECT 
    'workpackage_mode'                AS name,
    'Mode de travaux'                 AS label,
    'select'                           AS type,
    3                                  AS width,
    TRUE                              AS required,
    (SELECT workpackage_type  FROM project_workpackage WHERE workpackage_id = $workpackage_id::INTEGER ) as value,
    'Choisir un mode dans la liste'   AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='work_mode';

SELECT 
    'workpackage_type'                AS name,
    'Type de travaux'                 AS label,
    'select'                           AS type,
    3                                  AS width,
    TRUE                              AS required,
    (SELECT workpackage_type  FROM project_workpackage WHERE workpackage_id = $workpackage_id::INTEGER ) as value,
    'Choisir un type dans la liste'   AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='workpackage_type';


SELECT 
    'workpackage_date_start_scheduled' AS name,
    'Date de lancement prévue'       AS label,
    'date'                      AS type,
    3                            AS width,
        true                        AS required,
   (SELECT regex_value FROM regex WHERE regex_name='date')         AS pattern,
   (SELECT regex_description FROM regex WHERE regex_name='date')   AS description;


SELECT 
    'workpackage_duration_scheduled' AS name,
    'durée'                     AS label,
    'number'                    AS type,
    'jours'                     AS suffix,
    true                        AS required,
    'durée en jours'            AS description,
    3                           AS width;
