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
    'Hub lot de travaux'            AS title,
    '/e_project_workpackage/workpackage_hub_display_3.sql?workpackage_id='||$workpackage_id    AS link;

SELECT 
    'form' AS component,
    'Créer un lot de travaux' AS title,
    'Créer' AS validate,
    'Clear' AS reset,
    '/e_project_workpackage/workpackage_main_create_0.sql?project_id='||$project_id AS action;

SELECT
    'workpackage_name' AS name,
    'text' AS type,  
    'Nom' AS label,
    12 AS width,
    TRUE AS required;
SELECT
    'workpackage_summary' AS name,
    'textarea' AS type,
    'Présentation du lot de travux' AS label;

SELECT
    'workpackage_todo' AS name,
    'textarea' AS type,
    'Travaux à faire...' AS description,
    'Travaux à faire' AS label;

SELECT 
    'workpackage_type'                AS name,
    'Mode de travaux'                 AS label,
    'select'                           AS type,
    3                                  AS width,
    TRUE                              AS required,
    'Choisir un type dans la liste'   AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name="workpackage_type";

SELECT 
    'workpackage_cost_estimated' AS name,
    'cout estimé'              AS label,
    'number'                   AS type,
    'euros'                    AS suffix,
    'cout estimé HT'           AS description,
    6                         AS width;
