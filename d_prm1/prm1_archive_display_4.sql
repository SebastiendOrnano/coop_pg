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
    'Gestion des personnes physiques'            as title,
    '/d_prm1/prm1_main_display_4.sql' as link;

-- selection panel

SELECT 
    'alert'                    as component,
    'teal'                     as color,
     3 as width,
    'Sélectionner d''abord les membres puis appliquer le traitement choisi' as description;

SELECT
    'datagrid'              as component,
    'panel_archive_display' as id,
    'Visualiser les membres archivés pour les désarchiver' as title;
SELECT
    '/d_prm1/prm1_archive_active_0.sql'       as link,
    'caret-up-down'                                 as icon,
    'blue'                                          as color,
    'changer le statut archived -> active'          as description;
SELECT
    '/d_prm1/prm1_archive_no_0.sql'       as link,
    'cancel'                                 as icon,
    'yellow'                                          as color,
    'annuler la sélection'                            as description;
SELECT
    '/d_prm1/prm1_archive_select_all_0.sql'       as link,
    'list-check'                                 as icon,
    'blue'                                          as color,
    'tout selectionner'                            as description;

-- table de sélection des membres 

SELECT 'table' AS component, 
    'Liste des utilisateur'      AS title, 
    'View'                       AS markdown,
      'download_archived_table'   as id,
    TRUE                       AS sort, 
    TRUE                   AS search;

SELECT  
    prm1_id as Id,
    prm1_last_name     AS Nom,
    prm1_first_name  AS Prénom,
    prm1_status as statut,
    prm1_selected as selected,
  '[select / unselect](/d_prm1/prm1_archive_yes_0.sql?prm1_id=' || prm1_id ||')'    AS View
FROM prm1
WHERE prm1_last_name IS NOT NULL AND prm1_status !='active' 
ORDER BY created_at DESC;