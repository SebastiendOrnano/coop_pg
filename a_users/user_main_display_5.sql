SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_5.sql') AS properties;

SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion Admin'         AS title,
    '/a_panels/panel_admin_5.sql' AS link;

SELECT 
    'datagrid'              AS component,
    'panel_choice_display' AS id,
    'Gestion des utilisateurs' AS title;
SELECT 
    '/a_users/user_new_display_5.sql'     AS link,
    'Comptes en attente'                  AS description,
    'user-plus'                                      AS icon,
    'yellow'                                         AS color;
SELECT 
    '/a_users/user_archive_display_5.sql'     AS link,
    'Comptes boqués ou archivés'                  AS description,
    'archive'                                      AS icon,
    'green'                                         AS color;
SELECT 
    '/a_users/user_select_display_5.sql'     AS link,
    'Edition par lots'                       AS description,
    'users-group'                            AS icon,
    'blue'                                   AS color;
SELECT 
    'user_main_csv_full_0.sql'     AS link,
    'Télécharger la liste'         AS description,
    'download'                     AS icon,
    'red'                          AS color;


-- Display list of users
SELECT 'table' AS component, 
    'Liste des utilisateur'   AS title, 
    'View'                    AS markdown,
    TRUE                      AS sort, 
    TRUE                      AS search;

SELECT       
    user_id        AS Id,
    username       AS Nom,
    user_status    AS Statut,
    user_role      AS Droits,
    user_group     AS Groupe,
    user_level     AS Data,
    user_email     AS Email,
   '[Rights](/a_users/user_main_edit_5.sql?user_id=' || users.user_id || ')&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Delete](user_main_delete_alert1_5.sql?user_id=' || users.user_id || ')'    AS View
FROM users
WHERE user_id IS NOT NULL  AND user_status = 'active' AND user_role != '' AND user_role IS NOT NULL

ORDER BY created_at DESC;