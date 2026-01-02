SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_3.sql') AS properties;

set prm2_name=(SELECT prm2_name  FROM prm2 WHERE prm2_id = $prm2_id::INTEGER);

SELECT 
    'breadcrumb' as component;
SELECT 
    'Home' as title,
    '/'    as link;
SELECT 
    'Gestion Editeur'         as title,
    '/a_panels/panel_editor_3.sql' as link;

SELECT 
    'Gestion des organisations'            as title,
    '/d_prm2/prm2_main_display_3.sql'      as link;

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
    JSON('{"name":"Employés","tooltip":"Employés","link":"/d_prm2_sub_employees/prm2_sub_employee_main_display_3.sql?prm2_sub_id={id}","icon":"users"}') as custom_actions,
    JSON('{"name":"View","tooltip":"Fiche descriptive de la structure","link":"/d_prm2_sub/prm2_sub_main_view_3.sql?prm2_sub_id={id}","icon":"paperclip"}') as custom_actions,
    JSON('{"name": "doc","tooltip": "doc","link": "/d_prm2_sub_doc/prm2_sub_doc_main_display_3.sql?prm2_sub_id={id}","icon": "paperclip"}') as custom_actions,
    '/d_prm2_sub/prm2_sub_main_edit_3.sql?prm2_sub_id={id}' as edit_url,

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

