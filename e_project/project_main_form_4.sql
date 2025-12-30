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
    'Gestion des projets'            AS title,
    '/e_project/project_main_display_4.sql'      AS link;


SELECT 
    'form' AS component,
    'Créer un projet' AS title,
    'Créer' AS validate,
    'project_main_create_0.sql' AS action;

SELECT
    'project_name' AS name,
    'text' AS type,  
    'Nom' AS label,
    TRUE AS required;

SELECT
    'project_summary' AS name,
    'textarea' AS type,  
    'Présentation générale' AS label;

SELECT 
    'project_date_creation'      AS name,
    'Date de création'           AS label,
    'date'                       AS type,
        TRUE                           AS required,
    3                            AS width,
   (SELECT regex_value FROM regex WHERE regex_name='date')         AS pattern,
   (SELECT regex_description FROM regex WHERE regex_name='date')   AS description;

SELECT 
    'project_date_start_scheduled'      AS name,
    'Date de lancement prévue'           AS label,
        TRUE                           AS required,
    'date'                       AS type,
    3                            AS width,
   (SELECT regex_value FROM regex WHERE regex_name='date')         AS pattern,
   (SELECT regex_description FROM regex WHERE regex_name='date')   AS description;

SELECT 
    'project_duration_scheduled' AS name,
    'durée'                     AS label,
    'number'                    AS type,
    'jours'                     AS suffix,
    true                        AS required,
    'durée en jours'            AS description,
    3                           AS width;

SELECT 
    'project_category'             AS name,
    'Catégorie'                    AS label,
    'select'                       AS type,
    TRUE                           AS required,
    3                              AS width,
    'Choisir un statut dans la liste...'    AS  empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='project_category';


















