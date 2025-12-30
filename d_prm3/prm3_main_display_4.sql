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
    'datagrid'              as component,
    'panel_prm3_display' as id,
    'Gestion des groupements' as title;

SELECT 
    '/d_prm3/prm3_main_form_4.sql'     as link,
    'Création d''un nouveau groupement'                  as description,
    'user-plus'                                      as icon,
    'yellow'                                         as color;

SELECT 
     '/d_prm3/prm3_archive_display_4.sql'             as link,
    'Visualiser les groupements achivés'           as description,
    'archive'                                     as icon,
    'green'                                              as color;


-- Display list of organizations
SELECT 'table' AS component, 
    'Liste des organisations'   AS title, 
    JSON('{"name":"Participants","tooltip":"Membres","link":"/d_prm3_participants/prm3_participant_main_display_4.sql?prm3_id={id}","icon":"users"}') as custom_actions,
    JSON('{"name":"Doc","tooltip":"Documents","link":"/d_prm3_doc/prm3_doc_main_display_4.sql?prm3_id={id}","icon":"paperclip"}') as custom_actions,
    '/d_prm3/prm3_main_edit_4.sql?prm3_id={id}' as edit_url,
    '/d_prm3/prm3_main_delete_alert_4.sql?prm3_id={id}' as delete_url,
    TRUE             AS sort, 
    TRUE             AS search;

SELECT
    prm3_id           AS Id,
    prm3_id           AS _sqlpage_id,
    prm3_name        AS Nom,
    prm3_type         AS Type,
    prm3_category     AS Categorie,
    prm3_formal      AS Formel
FROM prm3
WHERE prm3_name IS NOT NULL AND prm3_status !='archived' 
ORDER BY prm3_id ASC;
