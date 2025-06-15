SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SELECT 
    'breadcrumb' as component;
SELECT 
    'Home' as title,
    '/'    as link;
SELECT 
    'Gestion Superviseur'                      as title,
    'arrow_left_double'                  as icon,
    '/a_panels/panel_supervisor_4.sql'        as link;
SELECT 
    'Liste des processus'                            as title,
    'arrow_left_double'                              as icon,
    '/a_process/process_supervisor_display_4.sql'        as link;


SELECT 
    'steps'  as component,
    TRUE     as counter,
    'purple' as color;
SELECT 
    process_step_title           as title,
    process_step_icon            as icon,
    process_step_link            as link,
    process_step_description     as description
    FROM process_steps WHERE process_id=$process_id::INTEGER 
    order by process_step_number asc;