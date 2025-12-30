SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_3.sql') AS properties;

set prm2_id= SELECT prm2_id FROM prm2_sub WHERE prm2_sub_id=$prm2_sub_id::INTEGER;

SELECT 
    'breadcrumb' as component;
SELECT 
    'Home' as title,
    '/'    as link;
SELECT 
    'Gestion éditeur'         as title,
    '/a_panels/panel_editor_3.sql' as link;
 SELECT 
    'Gestion du département'            as title,
    '/d_prm2_sub/prm2_sub_main_display_3.sql?prm2_id='||$prm2_id  as link;


SELECT 
    'datagrid'              as component,
    'panel_member_main_display' as id,
    'Gestion des membres de l''organisation' as title;
SELECT 
    '/d_prm2_sub_employees/prm2_sub_employee_main_form1_3.sql?prm2_sub_id='||$prm2_sub_id            as link,
    'Création d''un nouvel employé'                  as description,
    'user-plus'                                      as icon,
    'yellow'                                         as color;
SELECT 
    '/d_prm2_sub_employees/prm2_sub_employee_select_display_3.sql?prm2_sub_id='||$prm2_sub_id as link,
    'Actualiser les données d''une sélection'           as description,
    'file-download'                                     as icon,
    'green'                                              as color;
SELECT 
    '/d_prm2_sub_employees/prm2_sub_employee_csv_full_0.sql?prm2_sub_id='||$prm2_sub_id as link,
    'Téléchargement de la liste de tous les employés'     as description,
    'file-download'                                      as icon,
    'green'                                              as color;
SELECT  
    '/d_prm2_sub_employees/prm2_sub_employee_csv_email_0.sql?prm2_sub_id='||$prm2_sub_id as link,
    'Téléchargement email des employés'                     as description,
    'file-download'                                         as icon,
    'blue'                                                  as color;

SELECT 
    'title'     as component,
    'Structure employeuse'    as contents,
    3           as level;

SELECT 
    'form' as component,
    '' as validate;

SELECT 
    'prm2_id' as name,
    'hidden' as type,
    $prm2_id as value,
    'id' as label;

SELECT 
    'prm2_sub_id' as name,
    'hidden' as type,
    $prm2_sub_id as value,
    'id' as label;

SELECT
    'prm2_sub_name' as name,
    TRUE as readonly,
    'Nom de la filiale ou du département' as label,
     6 as width,
    (SELECT prm2_sub_name  FROM prm2_sub WHERE prm2_sub_id = $prm2_sub_id::INTEGER ) as value;

SELECT
    'prm2_name' as name,
    'text' as type,
    TRUE as readonly, 
    'Nom de la organisation mère' as label,
    6 as width,
    (SELECT prm2_name  FROM prm2 WHERE prm2_id = $prm2_id::INTEGER ) as value;

SELECT 
    'title'     as component,
    'Liste des employés'    as contents,
    3           as level;

SELECT 
    'table'               AS component, 
    TRUE                  AS sort, 
    JSON('{"name":"Profil","tooltip":"Profil","link":"/d_prm2_sub_employees/prm2_sub_employee_profile_display_3.sql?employee_id={id}","icon":"user-circle"}') as custom_actions,
    '/d_prm2_sub_employees/prm2_sub_employee_main_edit_alert1_3.sql?employee_id={id}' as edit_url,
    TRUE                  AS search;

SELECT
    e.employee_id                   AS id,
    p.prm1_first_name                 AS Prénom,
    P.prm1_last_name                 AS Nom,
    e.employee_function              AS Poste,
    e.employee_category              AS Categorie
FROM prm1 as p
LEFT JOIN (SELECT employee_id, employee_function, employee_category, employee_status, prm2_sub_id, prm1_id FROM prm2_sub_employees) as e
ON p.prm1_id = e.prm1_id
WHERE e.prm2_sub_id = $prm2_sub_id::INTEGER AND e.employee_status='active'
ORDER BY created_at ASC;