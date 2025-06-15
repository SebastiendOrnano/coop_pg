SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion Superviseur'         AS title,
    '/a_panels/panel_supervisor_4.sql' AS link;


-- Supervisor panel to manage orga_partners
SELECT 
    'datagrid'              AS component,
    'panel_orga_partner_display' AS id;

SELECT 
    '/b_orga_partners/orga_partner_form_4.sql'                   AS link,
    'Création d''un nouveau partenaire'                  AS description,
    'user-plus'                                      AS icon,
    'yellow'                                         AS color;

SELECT 
     '/b_orga_partners/orga_partner_archive_display_4.sql'             AS link,
    'Visualiser les partenaires achivés'           AS description,
    'file-download'                                     AS icon,
    'green'                                              AS color;


SELECT
    'divider' AS component,
    'black' AS color,
    'left' AS position,
    'Liste de nos partenaires' AS contents;

-- Display list of  active partners



/* 
if you want to paginate the table of orga_partners you have to uncomment the following button 
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
    'View'           AS markdown,
    'Img'  AS markdown,
    TRUE             AS sort, 
    TRUE             AS search;

SELECT       
   --'![view picture]('||$picture||')'    AS Img,
   '![view picture]('||orga_partner_logo_url||')' AS Img,
   orga_partner_name     AS Nom,
   orga_partner_acronym  AS Sigle,
    orga_partner_type    AS Type,
   orga_partner_category     AS Categorie,
   orga_partner_status AS statut,
  '[Edit](/b_orga_partners/orga_partner_edit_4.sql?orga_partner_id=' || orga_partner_id || ')&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Delete](/b_orga_partners/orga_partner_delete_0.sql?orga_partner_id=' || orga_partner_id|| ')'    AS View
FROM orga_partners
WHERE orga_partner_name IS NOT NULL AND orga_partner_status !='archived'
ORDER BY orga_partner_type asc
-- LIMIT IFNULL($page, 20) OFFSET IFNULL($offset, 0)
;

