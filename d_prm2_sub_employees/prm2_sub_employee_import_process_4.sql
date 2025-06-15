SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SELECT 
    'breadcrumb' as component;
SELECT 
    'Home' as title,
    '/'    as link;
SELECT 
    'Gestion Superviseur'         as title,
    '/a_panels/panel_supervisor_4.sql' as link;
SELECT 
    'Gestion des departements'            as title,
    '/d_prm2_sub/prm2_sub_main_display_4.sql?prm2_id='||$prm2_id  as link;
SELECT 
    'Gestion des employés'            as title,
    '/d_prm2_sub_employees/prm2_sub_employee_main_display_4.sql?prm2_sub_id='||$prm2_sub_id  as link;

SELECT 
    'datagrid'              as component,
    'panel_member_main_display' as id,
    'Gestion des membres de l''organisation' as title;
SELECT 
    '/d_prm2_sub_employees/prm2_sub_employee_import_csv_4.sql?prm2_sub_id='||$prm2_sub_id as link,
    'Importation à partir d''un fichier csv'                as description,
    'user-plus'                                             as icon,
    'yellow'                                                as color;


SELECT 
    'steps'  as component,
    TRUE     as counter,
    'purple' as color;
SELECT 
    process_step_title           as title,
    process_step_icon            as icon,
    process_step_link            as link,
    process_step_description     as description
    FROM process_steps WHERE process_id='5'
    order by process_step_number asc;