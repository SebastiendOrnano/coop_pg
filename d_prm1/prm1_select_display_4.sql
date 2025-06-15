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

SELECT 
    'alert'                    as component,
    'teal'                     as color,
     3 as width,
    'Sélectionner d''abord les membres puis appliquer le traitement choisi' as description;

SELECT
    'datagrid'              as component,
    'panel_prm1_display' as id,
    'Traitements sur une sélection membres de l''prm2nisation' as title;


SELECT
    '/d_prm1/prm1_select_no_0.sql'               as link,
    'cancel'                                as icon,
    'yellow'                                          as color,
    'annuler la sélection'                            as description;

SELECT
    '/d_prm1/prm1_select_all_0.sql'               as link,
    'Tout sélectionner'                                      as description,
    'list-check'                                     as icon,
    'red'                                               as color;

SELECT
    '/d_prm1/prm1_select_edit_4.sql'             as link,
    'Actualiser la liste des personnes sélectionnées'    as description,
    'edit'                                       as icon,
    'green'                                           as color;

SELECT
    '/d_prm1/prm1_select_delete_alert1_4.sql'             as link,
    'Supprimer les personnes sélectionnées'    as description,
    'user-off'                                       as icon,
    'blue'                                           as color;

SELECT
    '/d_prm1/prm1_select_csv_full_0.sql'           as link,
    'Télécharger la liste des personnes sélectionnées'     as description,
    'download'                                         as icon,
    'orange'                                            as color,
    'rechargez la page après l''export des données'     as tooltip;

SELECT
    '/d_prm1/prm1_select_csv_email_0.sql'                as link,
    'Télécharger email-téléphone des personnes sélectionnée'    as description,
    'download'                                               as icon,
    'green'                                                   as color,
    'rechargez la page après l''export des données'           as tooltip;






-- table de sélection des membres 

SELECT 'table' AS component, 
    'Liste des personnes'   AS title, 
    'View'           AS markdown,
    'download_selection_table' as id,
    'Img'  as markdown,
    TRUE             AS sort, 
    TRUE             AS search;

SELECT  
    prm1_last_name     AS Nom,
    prm1_first_name  AS Prénom,
    prm1_selected as selected,
  '[select / unselect](/d_prm1/prm1_select_yes_0.sql?prm1_id=' || prm1_id ||')'    AS View
FROM prm1
WHERE prm1_last_name IS NOT NULL AND prm1_status !='archived' 
ORDER BY created_at DESC;




