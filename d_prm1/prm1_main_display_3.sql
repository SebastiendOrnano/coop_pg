SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_3.sql') AS properties;

SELECT 
    'breadcrumb' as component;
SELECT 
    'Home' as title,
    '/'    as link;
SELECT 
    'Gestion éditeur'         as title,
    '/a_panels/panel_editor_3.sql' as link;



-- Supervisor panel to manage prm1
SELECT 
    'datagrid'              as component,
    'panel_prm1_display' as id,
    'PMR : gestion des personnes physiques' as title;

SELECT 
    '/d_prm1/prm1_main_form_3.sql'                   as link,
    'Création d''une nouvelle personne'                  as description,
    'user-plus'                                      as icon,
    'yellow'                                         as color;

SELECT 
     '/d_prm1/prm1_select_display_3.sql'             as link,
    'Actualiser les données d''une sélection'           as description,
    'edit'                                     as icon,
    'green'                                              as color;


SELECT 
    '/d_prm1/prm1_csv_full_0.sql'                   as link,
    'Téléchargement de la liste de tous les personnes'     as description,
    'file-download'                                      as icon,
    'green'                                              as color;

SELECT  
   '/d_prm1/prm1_csv_email_0.sql'                     as link,
    'Téléchargement email des personnes'                     as description,
    'file-download'                                         as icon,
    'blue'                                                  as color;

-- Display list of  active prm1



/* 
if you want to paginate the table of prm1 you have to uncomment the following button 
AND the final line
LIMIT IFNULL($page, 20) OFFSET IFNULL($offset, 0)
at the end of the table component

but if you paginate, the search on a name will be only in the page of screen !
*/

/* 
SELECT 
    'button' as component,
    TRUE AS center;

SELECT 
    '|<' as title, 
    '?offset=0&page=' || IFNULL($page, 20) as link,
    cast(IFNULL($offset, 0) as integer) <= 0 as disabled;

SELECT '<<' as title, 
    '?offset=' || (IFNULL($offset, 0) - IFNULL($page, 20)) || '&page=' || IFNULL($page, 20) as link,
    cast(IFNULL($offset, 0) as integer) <= 0 as disabled;

SELECT '>>' as title, 
  '?offset=' || (IFNULL($offset, 0) + IFNULL($page, 20)) || '&page=' || IFNULL($page, 20) as link; */

SELECT 'table' AS component, 
    'Liste des personnes'   AS title, 
    JSON('{"name":"View","tooltip":"Voir le profil","link":"/d_prm1/prm1_profile_display_3.sql?prm1_id={id}","icon":"user-circle"}') as custom_actions,
    JSON('{"name":"Doc","tooltip":"Documents liés à la personne","link":"/d_prm1_doc/prm1_doc_main_display_3.sql?prm1_id={id}","icon":"paperclip"}') as custom_actions,
    '/d_prm1/prm1_main_edit_3.sql?prm1_id={id}' as edit_url,
    'Img'  as markdown,
    TRUE             AS sort, 
    TRUE             AS search;

SELECT   
   prm1_id            AS Id, 
   prm1_id            AS _sqlpage_id,   
   prm1_last_name     AS Nom,
   prm1_first_name    AS Prénom,
   prm1_category      AS Categorie,
   prm1_status        as statut
FROM prm1
WHERE prm1_last_name IS NOT NULL AND prm1_status ='active'
ORDER BY prm1_last_name asc
-- LIMIT IFNULL($page, 20) OFFSET IFNULL($offset, 0)
;

