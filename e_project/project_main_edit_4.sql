SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion Superviseur'         AS title,
    '/a_panels/panel_supervisor_4.sql' AS link;
SELECT 
    'Projets'            AS title,
    '/e_project/project_main_display_4.sql'      AS link;

SELECT 
    'form' AS component,
    'Actualiser les données d''un projet' AS title,
    'Mettre à jour' AS validate,
    'Clear' AS reset,
    '/e_project/project_main_update_0.sql?project_id='||$project_id  AS action;

 SELECT 
    'project_status'            AS name,
    'Statut'                 AS label,
    'select'                 AS type,
    2 AS width,
    TRUE                     AS required,
    (SELECT project_status  FROM project WHERE project_id = $project_id::INTEGER ) AS value,
    'choisir unstatut dans la liste...'    AS  empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='status';

SELECT
    'project_name' AS name,
    'text' AS type,  
    'Nom' AS label,
    8 AS width,
    TRUE AS required,
    (SELECT project_name  FROM project WHERE project_id = $project_id::INTEGER ) AS value;

SELECT
    'project_summary' AS name,
    'textarea' AS type,  
    'Pitch' AS label,
    (SELECT project_summary  FROM project WHERE project_id = $project_id::INTEGER ) AS value;

SELECT 
    'project_date_creation' AS name,
    'Date de création'       AS label,
    'date'                      AS type,
    (SELECT project_date_creation  FROM project WHERE project_id = $project_id::INTEGER ) AS value,
    3                            AS width,
   (SELECT regex_value FROM regex WHERE regex_name='date')         AS pattern,
   (SELECT regex_description FROM regex WHERE regex_name='date')   AS description;

SELECT 
    'project_date_start_scheduled'      AS name,
    'Date de lancement prévue'           AS label,
    'date'                       AS type,
    3                            AS width,
    (SELECT project_date_start_scheduled  FROM project WHERE project_id = $project_id::INTEGER ) AS value,
   (SELECT regex_value FROM regex WHERE regex_name='date')         AS pattern,
   (SELECT regex_description FROM regex WHERE regex_name='date')   AS description;

SELECT 
    'project_date_start_actual'      AS name,
    'Date de lancement réelle'           AS label,
    'date'                       AS type,
    3                            AS width,
    (SELECT project_date_start_actual  FROM project WHERE project_id = $project_id::INTEGER ) AS value,
   (SELECT regex_value FROM regex WHERE regex_name='date')         AS pattern,
   (SELECT regex_description FROM regex WHERE regex_name='date')   AS description;

SELECT 
    'project_duration_scheduled' AS name,
    'durée prévue'                     AS label,
    'number'                    AS type,
    'jours'                     AS suffix,
    true                        AS required,
    'durée en jours'            AS description,
    (SELECT project_duration_scheduled  FROM project WHERE project_id = $project_id::INTEGER ) AS value,
    3                           AS width;

SELECT 
    'project_duration_actual'   AS name,
    'durée réelle'              AS label,
    'number'                    AS type,
    'jours'                     AS suffix,
    'durée en jours'            AS description,
    (SELECT project_duration_actual  FROM project WHERE project_id = $project_id::INTEGER ) AS value,
    3                           AS width;

SELECT 
    'project_category'             AS name,
    'Catégorie'                    AS label,
    'select'                       AS type,
    6                              AS width,
    (SELECT project_category  FROM project WHERE project_id = $project_id::INTEGER ) AS value,
    'choisir une categorie dans la liste...'    AS  empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='project_category';