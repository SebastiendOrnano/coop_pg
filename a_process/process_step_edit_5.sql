SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_5.sql') AS properties;

SET process_id= SELECT process_id FROM process_steps WHERE process_step_id=$process_step_id::INTEGER ;

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
    'Liste des étapes du processus'                      AS title,
    'arrow_left'                  AS icon,
    '/a_process/process_step_display_5.sql?process_id='||$process_id     AS link;


-- Form for replying to the step
SELECT 'form'      AS component,
 'multipart/form-data' AS enctype,
 'Actualiser une étape' AS validate,
 '/a_process/process_step_update_0.sql?process_step_id='||$process_step_id AS action;


SELECT 
'process_step_number'        AS name, 
'number'                     AS type, 
'N° d''ordre de l''étape'    AS label,
2                            AS width,
(SELECT process_step_number  FROM process_steps WHERE process_step_id = $process_step_id::INTEGER ) AS value,
TRUE                         AS required;

SELECT 
'process_step_icon'      AS name, 
'text'                   AS type, 
2                        AS width,
(SELECT process_step_icon  FROM process_steps WHERE process_step_id = $process_step_id::INTEGER ) AS value,
'icon'                   AS label;

SELECT 
'process_step_title'           AS name, 
'text'                         AS type, 
'Nom de l''étape'              AS label,
8                       AS width,
(SELECT process_step_title  FROM process_steps WHERE process_step_id = $process_step_id::INTEGER ) AS value,
TRUE                           AS required;

SELECT 
'process_step_link'           AS name, 
'text'                        AS type,
(SELECT process_step_link  FROM process_steps WHERE process_step_id = $process_step_id::INTEGER ) AS value,
'link'                        AS label;

SELECT 
'process_step_description'           AS name, 
'textarea'                               AS type,
(SELECT process_step_description  FROM process_steps WHERE process_step_id = $process_step_id::INTEGER ) AS value,
'description'                        AS label;




