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
    'Liste des processus'                      AS title,
    'arrow_left_double'                  AS icon,
    '/a_process/process_main_display_5.sql'        AS link;
SELECT 
    'Retour au processus'                      AS title,
    'arrow_left'                  AS icon,
    '/a_process/process_main_display_5.sql?process_id='||$process_id     AS link;


SELECT 
    'title'   AS component,
    'Nouvelle étape' AS contents,
    3         AS level;

-- Form for replying to the topic
SELECT 'form'      AS component,
'Créer une nouvelle étape' AS validate,
'Clear'                    AS reset,
'/a_process/process_step_create_0.sql?process_id='||$process_id AS action;


SELECT 
'process_step_number'        AS name, 
'number'                     AS type, 
'N° d''ordre de l''étape'    AS label,
2                            AS width,
TRUE                         AS required;

SELECT 
'process_step_icon'      AS name, 
'text'                   AS type, 
2                        AS width,
'icon'                   AS label;

SELECT 
'process_step_title'           AS name, 
'text'                         AS type, 
'Nom de l''étape'              AS label,
TRUE                           AS required;

SELECT 
'process_step_link'           AS name, 
'text'                        AS type, 
'link'                        AS label;

SELECT 
'process_step_description'           AS name, 
'text'                               AS type, 
'description'                        AS label;
