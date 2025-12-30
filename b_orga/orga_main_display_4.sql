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
    'datagrid'              AS component,
    'panel_orga_display' AS id,
    'Gestion des partenaires de l''organisation' AS title;

SELECT 

    '/b_orga/orga_main_form_4.sql'     AS link,
    'Création d''une nouvelle organisation'                  AS description,
    'affiliate'                                      AS icon,
    'yellow'                                         AS color;

SELECT 
 
    '/b_orga/orga_archive_display_4.sql'             AS link,
    'Visualiser les organisations achivées'           AS description,
    'archive'                                         AS icon,
    'green'                                              AS color;



-- Display list of organizations
SELECT 'table' AS component, 
    'Liste des organisations'   AS title, 
    JSON('{"name":"Dept","tooltip":"Dept","link":"/b_orga_dept/orga_dept_main_display_4.sql?orga_id={id}","icon":"building-factory-2"}') as custom_actions,
    '/b_orga/orga_main_edit_4.sql?orga_id={id}' as edit_url,
    '/b_orga/orga_main_delete_alert_4.sql?orga_id={id}' as delete_url,
    TRUE             AS sort, 
    TRUE             AS search;

SELECT
    orga_id          AS Id,
    orga_id          AS _sqlpage_id,
    orga_name        AS Nom,
    orga_town        AS Ville
FROM orga
WHERE orga_name IS NOT NULL AND orga_status !='archived' 
ORDER BY orga_id ASC;
