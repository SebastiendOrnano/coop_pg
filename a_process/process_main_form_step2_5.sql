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
    '/a_process/process_main_form_step2_0.sql' AS action;

SELECT
    'process_section_title' AS name,
    'text' AS type,  
    'Nom de l''étape' AS label,
    6 AS width;

SELECT 
   'process_name' AS name,
    'Nom du process' AS label,
    'select' AS type,
    6 AS width,
    1      AS value,
    'SELECT an option in the dropdown list' AS description,
    json_agg(JSON_BUILD_OBJECT('label', process_name,'value', process_id)) AS options FROM process;

SELECT 
   'process_section_number' AS name,
    'Numéro de l''étape' AS label,
   'text' AS type,  
    6 AS width;

SELECT 
   'process_section_description' AS name,
    'Description de l''étape' AS label,
   'text' AS type,  
    6 AS width;

SELECT 
   'process_section_icon' AS name,
    'Icone de l''étape' AS label,
   'text' AS type,  
    6 AS width;

SELECT 
   'process_section_link' AS name,
    'Lien de l''étape' AS label,
   'text' AS type,  
    6 AS width;
