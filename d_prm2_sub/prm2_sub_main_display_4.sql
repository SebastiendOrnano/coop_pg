SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;


set prm2_name=(SELECT prm2_name  FROM prm2 WHERE prm2_id = $prm2_id::INTEGER);



SELECT 
    'breadcrumb' as component;
SELECT 
    'Home' as title,
    '/'    as link;
SELECT 
    'Gestion Superviseur'         as title,
    '/a_panels/panel_supervisor_4.sql' as link;
SELECT 
    'Gestion des organisations'            as title,
    '/d_prm2/prm2_main_display_4.sql'      as link;

SELECT 
    'datagrid'              AS component;
SELECT 
    '/d_prm2_sub/prm2_sub_main_form_4.sql?prm2_id='||$prm2_id   AS link,
    'Création d''une nouvelle organisation'                  AS description,
    'user-plus'                                      AS icon,
    'yellow'                                         AS color;
SELECT 
     '/d_prm2_sub/prm2_sub_archive_display_4.sql?prm2_id='||$prm2_id             AS link,
    'Visualiser les organisations achivées'           AS description,
    'file-download'                                     AS icon,
    'green'                                              AS color;

SELECT 
    'divider' as component,
    'Nom de l''organisation mère'    as contents,
    'blue' as color;

SELECT 
    'form'   as component,
    '' as validate;
SELECT
    'prm2_id' as name,
    TRUE as readonly,
    'Id ' as label,
    1 as width,
   $prm2_id as value;
SELECT
    'prm2_name' as name,
    TRUE as readonly,
    'Nom de l''organisation mère' as label,
    11 as width,
    (SELECT prm2_name  FROM prm2 WHERE prm2_id = $prm2_id::INTEGER ) as value;
 
SELECT 
    'divider' as component,
    'Départements ou filiales'    as contents,
    'blue' as color;



SELECT 
    'table'               AS component, 
    'Départements ou filiales' AS title, 
    TRUE                  AS sort, 
    JSON('{"name":"Employés","tooltip":"Employés","link":"/d_prm2_sub_employees/prm2_sub_employee_main_display_4.sql?prm2_sub_id={id}","icon":"users"}') as custom_actions,
    JSON('{"name":"Doc","tooltip":"Documents","link":"/d_prm2_sub_doc/prm2_sub_doc_main_display_4.sql?prm2_sub_id={id}","icon":"paperclip"}') as custom_actions,
    JSON('{"name":"View","tooltip":"Fiche descriptive de la structure","link":"/d_prm2_sub/prm2_sub_main_view_4.sql?prm2_sub_id={id}","icon":"clipboard-text"}') as custom_actions,
    '/d_prm2_sub/prm2_sub_main_edit_4.sql?prm2_sub_id={id}' as edit_url,
    '/d_prm2_sub/prm2_sub_main_delete_alert_4.sql?prm2_sub_id={id}' as delete_url,
    FALSE                 AS search;

SELECT
    prm2_sub_id            AS Id,
    prm2_sub_id            AS _sqlpage_id,
    prm2_sub_name            AS Nom,
    prm2_sub_postal_code    AS CodePostal,
    prm2_sub_town           AS Ville
FROM prm2_sub
WHERE prm2_id = $prm2_id::INTEGER
ORDER BY prm2_sub_id ASC;