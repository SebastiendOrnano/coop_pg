SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_5.sql') AS properties;

SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion Admin'                      AS title,
    'arrow_left_double'                  AS icon,
    '/a_panels/panel_admin_5.sql'        AS link;
SELECT 
    'List des processus'                      AS title,
    'arrow_left'                  AS icon,
    '/a_process/process_main_display_5.sql'        AS link;


SELECT 
    'alert'                     AS component,
    'Attention'                   AS title,
    TRUE AS important,
    'La saisie se fait en 2 étapes. Lors de la première étape vous pouvez saisir le process puis dans un second temps les étapes du process' AS description,
    'alert-triangle'            AS icon,
    TRUE                       AS dismissible,
    'yellow'                    AS color;

SELECT 
    'form' AS component,
    'Créer un process / étape 1' AS title,
    'Créer' AS validate,
   'Clear' AS reset,
    '/a_process/process_main_create_0.sql' AS action;

SELECT
    'process_title' AS name,
    'text' AS type,  
    'Nom du process' AS label;

SELECT
    'process_category'       AS name,
    'select'                   AS type,  
    'Rôle utilisateur'   AS label,
    TRUE                     AS required,
    4                       AS width,
    TRUE                     AS searchable,
    'Choisir un rôle dans la liste...' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label', i.choice_label, 'value', i.choice_value)) AS options
    FROM choices_items AS i 
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories) AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE c.choice_category_name = 'user_role';
SELECT
    'process_status'         AS name,
    'select'                 AS type,  
    'Statut'                 AS label,
    TRUE                     AS required,
    4                        AS width,
    TRUE                     AS searchable,
    'Choisir un statut dans la liste...' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label', i.choice_label, 'value', i.choice_value)) AS options
    FROM choices_items AS i 
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories) AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE c.choice_category_name = 'status';

SELECT
    'process_description' AS name,
    'text' AS type,  
    'Description du process' AS label;

