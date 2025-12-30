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

-- Supervisor panel to manage orga_partners
SELECT 
    'datagrid'              AS component,
    'panel_orga_partner_display' AS id;

SELECT 
    '/b_orga_dept_partners/orga_partner_form_4.sql?orga_dept_id='||$orga_dept_id AS link,
    'Création d''un nouveau partenaire'                  AS description,
    'user-plus'                                      AS icon,
    'yellow'                                         AS color;

SELECT 
     '/b_orga_dept_partners/orga_partner_archive_display_4.sql?orga_dept_id='||$orga_dept_id AS link,
    'Visualiser les partenaires achivés'           AS description,
    'archive'                                     AS icon,
    'green'                                              AS color;


SELECT
    'divider' AS component,
    'black' AS color,
    'left' AS position,
    'Liste de nos partenaires' AS contents;

SELECT 'table' AS component, 
    '/b_orga_dept_partners/orga_partner_edit_4.sql?orga_partner_id={id}' as edit_url,
    '/b_orga_dept_partners/orga_partner_delete_0.sql?orga_partner_id={id}' as delete_url,
    'Img'  AS markdown,
    TRUE             AS sort, 
    TRUE             AS search;

SELECT       
   '![view picture]('||orga_partner_logo_url||')' AS Img,
    orga_partner_id           as _sqlpage_id,
    orga_partner_name     AS Nom,
    orga_partner_acronym  AS Sigle,
    orga_partner_type    AS Type,
    orga_partner_category     AS Categorie,
    orga_partner_status AS statut
FROM orga_dept_partners
WHERE orga_partner_name IS NOT NULL AND orga_partner_status !='archived' AND orga_dept_id=$orga_dept_id::INTEGER
ORDER BY orga_partner_type asc
-- LIMIT IFNULL($page, 20) OFFSET IFNULL($offset, 0)
;

