SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_3.sql') AS properties;

SET project_id = SELECT project_id FROM project_workpackage WHERE workpackage_id = $workpackage_id::INTEGER ;
SET workpackage_parent_id = SELECT workpackage_parent_id FROM project_workpackage WHERE workpackage_id = $workpackage_id::INTEGER ;


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
    'Actualiser les données d''un lot de travaux' AS title,
    'Mettre à jour' AS validate,
    'Clear' AS reset,
    '/e_project_workpackage/workpackage_main_update_0.sql?workpackage_id='||$workpackage_id AS action;

SELECT
    'workpackage_name' AS name,
    'text' AS type,  
    'Nom' AS label,
    12 AS width,
    TRUE AS required,
    (SELECT workpackage_name  FROM project_workpackage WHERE workpackage_id = $workpackage_id::INTEGER ) as value;

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
    'workpackage_status'            AS name,
    'Statut'                 AS label,
    'select'                 AS type,
    3 AS width,
    TRUE                     AS required,
    (SELECT workpackage_status  FROM project_workpackage WHERE workpackage_id = $workpackage_id::INTEGER ) as value,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='status';

SELECT 
    'workpackage_mode'                AS name,
    'Mode de travaux'                 AS label,
    'select'                           AS type,
    3                                  AS width,
    TRUE                              AS required,
    (SELECT workpackage_mode  FROM project_workpackage WHERE workpackage_id = $workpackage_id::INTEGER ) as value,
    'Choisir un type dans la liste'   AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='work_mode';

SELECT
    'workpackage_summary' AS name,
    'textarea' AS type,  
    'Description' AS label,
    (SELECT workpackage_summary  FROM project_workpackage WHERE workpackage_id = $workpackage_id::INTEGER ) as value;

SELECT
    'workpackage_todo' AS name,
    'textarea' AS type,
    'Travaux à faire...' AS description,
    (SELECT workpackage_todo  FROM project_workpackage WHERE workpackage_id = $workpackage_id::INTEGER ) as value,
    'Travaux à faire' AS label;

SELECT 
    'workpackage_date_start_scheduled' AS name,
    'date'                      AS type,
    'date lancement prévue'     AS label,
    true                        AS required,
    'ne peut être modifié si le lot de travaux dépend d''un lot parent' as description,
    CASE
    WHEN $workpackage_parent_id IS NOT NULL
    THEN 'true '
    ELSE ''
    END as readonly,
    (SELECT workpackage_date_start_scheduled FROM project_workpackage WHERE workpackage_id = $workpackage_id::INTEGER ) as value,
    3                          AS width;

SELECT 
    'workpackage_duration_scheduled' AS name,
    'durée prévue'              AS label,
    'number'                      AS type,
    'jours'                    AS suffix,
    (SELECT workpackage_duration_scheduled  FROM project_workpackage WHERE workpackage_id = $workpackage_id::INTEGER ) as value,
    true                        AS required,
    'durée en jours'  AS description,
    3                          AS width;

SELECT 
    'workpackage_date_start_actual' AS name,
    'date'                      AS type,
    'date lancement réelle'     AS label,
    (SELECT workpackage_date_start_actual FROM project_workpackage WHERE workpackage_id = $workpackage_id::INTEGER ) as value,
    3                          AS width;

SELECT 
    'workpackage_duration_actual' AS name,
    'durée réelle'              AS label,
    'number'                      AS type,
    'jours'                    AS suffix,
    (SELECT workpackage_duration_actual  FROM project_workpackage WHERE workpackage_id = $workpackage_id::INTEGER ) as value,
    'durée en jours'  AS description,
    3                          AS width;

SELECT 
    'workpackage_cost_estimated' AS name,
    'cout estimé'              AS label,
    'number'                   AS type,
    'euros'                    AS suffix,
    (SELECT workpackage_cost_estimated  FROM project_workpackage WHERE workpackage_id = $workpackage_id::INTEGER ) as value,
    'cout estimé HT'           AS description,
    4                         AS width;

