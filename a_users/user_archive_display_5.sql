SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_5.sql') AS properties;

SELECT 
    'breadcrumb' as component;
SELECT 
    'Home' as title,
    '/'    as link;
SELECT 
    'Gestion Admin'            as title,
    '/a_panels/panel_admin_5.sql' as link;
 SELECT 
    'Retour Gestion des utilisateur actifs'         as title,
    '/a_users/user_main_display_5.sql'              as link;

SELECT 
    'csv'              as component,
    'Télécharger la liste des utilisateur archivés' as title,
    'utilisateurs'           as filename,
    'file-download'    as icon,
    'green'            as color,
    ';'                as separator,
    TRUE               as bom;
SELECT 
    username, user_first_name, user_last_name, user_email, user_role, user_group, user_level, user_status
FROM users  
WHERE username IS NOT NULL AND  user_status ='archived';

SELECT 
    'divider'              as component,
    'Liste des utilisateurs archivés ou inactifs' as contents,
    'left'                 as position,
    'black'                as color;

-- Display list of users
SELECT 'table' AS component, 
    'Liste des utilisateur'   AS title, 
    '/a_users/user_main_edit_5.sql?user_id={id}' as edit_url,
    '/a_users/suser_main_delete_alert1_5.sql?user_id={id}' as delete_url,
    TRUE                      AS sort, 
    TRUE                      AS search;

SELECT       
    user_id        AS Id,
    user_id        as _sqlpage_id,
    username       AS Nom,
    user_status    AS Statut,
    user_role      AS Droits,
    user_group     AS Groupe,
    user_level     AS Data,
    user_email     AS Email
FROM users
WHERE user_id IS NOT NULL AND  (user_status ='archived' OR user_status ='inactive')

ORDER BY created_at DESC;