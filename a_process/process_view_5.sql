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
    '/a_process/process_step_display_5.sql?process_id='||$process_id     AS link;

SELECT 
    'steps'  AS component,
    TRUE     AS counter,
    'purple' AS color;
SELECT 
    process_step_title           AS title,
    process_step_icon            AS icon,
    process_step_link            AS link,
    process_step_description     AS description
    FROM process_steps WHERE process_id=$process_id::INTEGER 
    order by process_step_number asc;