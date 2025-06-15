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
    'Gestion des membres'            AS title,
    '/b_members/member_main_display_4.sql' AS link;

SELECT 
    'alert'                    AS component,
    'teal'                     AS color,
     3 AS width,
    'Sélectionner d''abord les membres puis appliquer le traitement choisi' AS description;

SELECT
    'datagrid'              AS component,
    'panel_archive_display' AS id,
    'Visualiser les membres archivés pour les désarchiver' AS title;


SELECT
    '/b_members/member_archive_no_0.sql'       AS link,
    'corner-down-left'                                 AS icon,
    'yellow'                                          AS color,
    'annuler la sélection'                            AS description;

SELECT
    '/b_members/member_archive_active_0.sql'       AS link,
    'corner-down-left'                                 AS icon,
    'yellow'                                          AS color,
    'changer le statut -> active'                            AS description;

SELECT
    '/b_members/member_archive_inactive_0.sql'       AS link,
    'corner-down-left'                                 AS icon,
    'yellow'                                          AS color,
    'changer le statut -> non-active'                 AS description;






-- table de sélection des membres 

SELECT 'table' AS component, 
    'Liste des utilisateur'      AS title, 
    'View'                       AS markdown,
      'download_archived_table'   AS id,
    'Img'                        AS markdown,
    TRUE                       AS sort, 
    TRUE                   AS search;

SELECT  
    CONCAT ('![view picture](',member_picture_url,')' ) AS Img,
    member_id AS Id,
    member_last_name     AS Nom,
    member_first_name  AS Prénom,
    member_status AS statut,
    member_selected AS selected,
  '[select / unselect](/b_members/member_archive_yes_0.sql?member_id=' || member_id ||')'    AS View
FROM members
WHERE member_last_name IS NOT NULL AND member_status ='archived' 
ORDER BY created_at DESC;




