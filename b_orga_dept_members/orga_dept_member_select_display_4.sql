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
    '/b_orga_dept_members/orga_dept_member_main_display_4.sql?orga_dept_id='||$orga_dept_id AS link;

SELECT 
    'alert'                    AS component,
    'teal'                     AS color,
     3 AS width,
    'Sélectionner d''abord les membres puis appliquer le traitement choisi' AS description;

SELECT
    'datagrid'              AS component,
    'panel_member_main_display' AS id,
    'Traitements sur une sélection membres de l''organisation' AS title;

SELECT
     '/b_orga_dept_members/orga_dept_member_select_all_0.sql?orga_dept_id='||$orga_dept_id AS link,
    'Tout sélectionner'                                      AS description,
    'list-check'                                     AS icon,
    'red'                                               AS color;

SELECT
    '/b_orga_dept_members/orga_dept_member_select_no_0.sql?orga_dept_id='||$orga_dept_id AS link,
    'deselect'                                        AS icon,
    'yellow'                                          AS color,
    'annuler la sélection'                            AS description;

SELECT
    '/b_orga_dept_members/orga_dept_member_select_edit_4.sql?orga_dept_id='||$orga_dept_id AS link,
    'Actualiser la liste des membres sélectionnés'    AS description,
    'user-plus'                                       AS icon,
    'green'                                           AS color;

SELECT
    '/b_orga_dept_members/orga_dept_member_select_delete_alert1_4.sql?orga_dept_id='||$orga_dept_id AS link,
    'Supprimer les membres sélectionnés'              AS description,
    'user-off'                                        AS icon,
    'blue'                                            AS color;

SELECT
    '/b_orga_dept_members/orga_dept_member_select_csv_full_0.sql?orga_dept_id='||$orga_dept_id AS link,
    'Télécharger la liste des membres sélectionnés'     AS description,
    'user-plus'                                         AS icon,
    'orange'                                            AS color,
    'rechargez la page après l''export des données'     AS tooltip;

SELECT
    '/b_orga_dept_members/orga_dept_member_select_csv_email_0.sql?orga_dept_id='||$orga_dept_id AS link,
    'Télécharger email-téléphone des membres sélectionnés'    AS description,
    'user-plus'                                               AS icon,
    'green'                                                   AS color,
    'rechargez la page après l''export des données'           AS tooltip;






-- table de sélection des membres 

SELECT 'table' AS component, 
    'Liste des utilisateur'   AS title, 
    'View'           AS markdown,
    'download_selection_table' AS id,
    'Img'  AS markdown,
    TRUE             AS sort, 
    TRUE             AS search;

SELECT  
    CONCAT ('![view picture](',member_picture_url,')' ) AS Img,
    member_last_name     AS Nom,
    member_first_name  AS Prénom,
    member_selected AS selected,
  '[select / unselect](/b_orga_dept_members/orga_dept_member_select_yes_0.sql?member_id=' || member_id ||')'    AS View
FROM orga_dept_members
WHERE member_last_name IS NOT NULL AND member_status !='archived' 
ORDER BY created_at DESC;




