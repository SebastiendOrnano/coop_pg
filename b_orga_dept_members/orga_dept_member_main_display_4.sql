SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SET orga_id = SELECT orga_id FROM orga_dept WHERE orga_dept_id=$orga_dept_id::INTEGER;

SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion Superviseur'         AS title,
    '/a_panels/panel_supervisor_4.sql' AS link;
SELECT 
    'Gestion Organisation'         AS title,
    '/b_orga/orga_main_display_4.sql' AS link;
SELECT 
    'Structure mère'         AS title,
    '/b_orga_dept/orga_dept_main_display_4.sql?orga_id='||$orga_id AS link;


-- Supervisor panel to manage members
SELECT 
    'datagrid'              AS component,
    'panel_member_main_display' AS id,
    'Gestion des membres de l''organisation' AS title;

SELECT 

    '/b_orga_dept_members/orga_dept_member_main_form_4.sql?orga_dept_id='||$orga_dept_id    AS link,
    'Création d''un nouveau membre'                  AS description,
    'user-plus'                                      AS icon,
    'yellow'                                         AS color;

SELECT 
 
    '/b_orga_dept_members/orga_dept_member_select_display_4.sql?orga_dept_id='||$orga_dept_id    AS link,
    'Actualiser les données d''une sélection'           AS description,
    'file-download'                                     AS icon,
    'green'                                              AS color;

SELECT 
 
    '/b_orga_dept_members/orga_dept_member_archive_display_4.sql?orga_dept_id='||$orga_dept_id    AS link,
    'Visualiser les membres achivés'                       AS description,
    'file-download'                                     AS icon,
    'green'                                              AS color;

SELECT 
    '/b_orga_dept_members/orga_dept_member_import_csv_4.sql?orga_dept_id='||$orga_dept_id    AS link,
    'Importation à partir d''un fichier csv'                AS description,
    'user-plus'                                             AS icon,
    'yellow'                                                 AS color;

SELECT 
    '/b_orga_dept_members/orga_dept_member_csv_full_0.sql?orga_dept_id='||$orga_dept_id    AS link,
    'Téléchargement de la liste de tous les membres'     AS description,
    'file-download'                                      AS icon,
    'green'                                              AS color;

SELECT  
   '/b_orga_dept_members/orga_dept_member_csv_email_0.sql?orga_dept_id='||$orga_dept_id    AS link,
    'Téléchargement email des membres'                     AS description,
    'file-download'                                         AS icon,
    'blue'                                                  AS color;

SELECT 
    '/b_orga_dept_members/orga_dept_member_csv_subscription_0.sql?orga_dept_id='||$orga_dept_id    AS link,
    'Téléchargement des membres en retard de cotisation'    AS description,
    'file-download'                                         AS icon,
    'yellow'                                                  AS color;
  


-- Display list of  active members



/* 
if you want to paginate the table of members you have to uncomment the following button 
AND the final line
LIMIT IFNULL($page, 20) OFFSET IFNULL($offset, 0)
at the end of the table component

but if you paginate, the search on a name will be only in the page of screen !
*/

/* 
SELECT 
    'button' AS component,
    TRUE AS center;

SELECT 
    '|<' AS title, 
    '?offset=0&page=' || IFNULL($page, 20) AS link,
    cast(IFNULL($offset, 0) AS integer) <= 0 AS disabled;

SELECT '<<' AS title, 
    '?offset=' || (IFNULL($offset, 0) - IFNULL($page, 20)) || '&page=' || IFNULL($page, 20) AS link,
    cast(IFNULL($offset, 0) AS integer) <= 0 AS disabled;

SELECT '>>' AS title, 
  '?offset=' || (IFNULL($offset, 0) + IFNULL($page, 20)) || '&page=' || IFNULL($page, 20) AS link; */

SELECT 'table' AS component, 
    'Liste des utilisateur'   AS title, 
    'Img'            AS markdown,
 
    JSON('{"name":"Pict","tooltip":"Changer photo profil","link":"/b_orga_dept_members/orga_dept_member_picture_form_4.sql?member_id={id}","icon":"user-circle"}') as custom_actions,
    JSON('{"name":"Profil","tooltip":"Voir le profil","link":"/b_orga_dept_members/orga_dept_member_profile_complete_4.sql?member_id={id}","icon":"user-scan"}') as custom_actions,
    '/b_orga_dept_members/orga_dept_member_main_edit_4.sql?member_id={id}' as edit_url,
    '/b_orga_dept_members/orga_dept_member_main_delete_alert1_4.sql?member_id={id}' as delete_url,
    TRUE             AS sort, 
    TRUE             AS search;

SELECT       
   --'![view picture]('||$picture||')'    AS Img,
   '![view picture]('||member_picture_url||')' AS Img,
   member_last_name     AS Nom,
   member_first_name  AS Prénom,
   member_category     AS Categorie,
   member_function AS fonction,
   member_id          as _sqlpage_id,
   member_status AS statut,
   member_publish AS publie
FROM orga_dept_members
WHERE member_last_name IS NOT NULL AND member_status !='archived' AND orga_dept_id=$orga_dept_id::INTEGER
ORDER BY member_last_name asc
-- LIMIT IFNULL($page, 20) OFFSET IFNULL($offset, 0)
;

