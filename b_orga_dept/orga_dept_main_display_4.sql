SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion Superviseur'         AS title,
    '/a_panels/panel_supervisor_4.sql' AS link;

SELECT 
    'Gestion des organisations'            AS title,
    '/b_orga/orga_main_display_4.sql'      AS link;




SELECT 
    'form'   AS component,
    '' AS validate;

SELECT
    'orga_id' AS name,
    TRUE AS readonly,
    'Id ' AS label,
    1 AS width,
   $orga_id AS value;

SELECT
    'orga_name' AS name,
    TRUE AS readonly,
    'Nom de l''organisation mère' AS label,
    11 AS width,
    (SELECT orga_name  FROM orga WHERE orga_id = $orga_id::INTEGER ) AS value;
 

SELECT 
    'datagrid'              AS component,
    'Gestion des départements de l''organisation' AS title;

SELECT 
     '/b_orga_dept/orga_dept_main_form_4.sql?orga_id='||$orga_id  AS link,
    'Créer un nouveau departement'                     AS description,
    'sitemap'                                           AS icon,
    'green'                                              AS color;
SELECT 
     '/b_orga_dept/orga_dept_archive_display_4.sql?orga_id='||$orga_id  AS link,
    'Voir les départements archivés'                     AS description,
    'archive'                                           AS icon,
    'red'                                              AS color;
SELECT 
    'table'               AS component, 
    'Départements ou filiales' AS title, 
    TRUE                  AS sort, 
    JSON('{"name":"Membres","tooltip":"Membres","link":"/b_orga_dept_members/orga_dept_member_main_display_4.sql?orga_dept_id={id}","icon":"users"}') as custom_actions,
    JSON('{"name":"Doc","tooltip":"Documents","link":"/b_orga_dept_doc/orga_dept_doc_main_display_4.sql?orga_dept_id={id}","icon":"file-type-doc"}') as custom_actions,
    JSON('{"name":"Partners","tooltip":"Partenaires de la structure","link":"/b_orga_dept_partners/orga_partner_display_4.sql?orga_dept_id={id}","icon":"medal"}') as custom_actions,
    '/b_orga_dept/orga_dept_main_edit_4.sql?orga_dept_id={id}' as edit_url,
    '/b_orga_dept/orga_dept_main_delete_alert_4.sql?orga_dept_id={id}' as delete_url,
    FALSE                 AS search;

SELECT
    orga_dept_id            AS Id,
    orga_dept_id            AS _sqlpage_id,
    orga_dept_rank          AS Rank,
    orga_dept_name            AS Nom,
    orga_dept_postal_code    AS CodePostal,
    orga_dept_town           AS Ville
FROM orga_dept
WHERE orga_id = $orga_id::INTEGER AND orga_dept_status='active'
ORDER BY orga_dept_id ASC;