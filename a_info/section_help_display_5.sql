SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_5.sql') AS properties;

SELECT 
    'breadcrumb' AS component;
SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion admin'         AS title,
    '/a_panels/panel_admin_5.sql' AS link;
 
SELECT 
    'datagrid'              AS component,
    'Gestion des sections des manuels utilisateurs et développeurs' AS title;

SELECT
    '/a_info/section_help_form_5.sql'             AS link,
    'Créer une nouvelle section'                  AS description,
    'section'                                     AS icon,
    'yellow'                                      AS color;
SELECT
    '/a_info/section_help_archive_display_5.sql'  AS link,
    'Sections archivées'                          AS description,
    'archive'                                     AS icon,
    'blue'                                        AS color;

/*render the table
SELECT 'table' AS component;
SELECT * FROM todo
WHERE id >= COALESCE($start_id, 0) ORDER BY id LIMIT 5;

-- render the page numbers with links for pagination
SELECT 'steps' AS component, true AS counter;
SELECT format('?start_id=%s', id) AS link
FROM (SELECT id, ROW_NUMBER() OVER (ORDER BY id) AS table_index FROM todo)
WHERE table_index % 5 = 1;*/



-- Display list of sections
SELECT 'table' AS component, 
    'Liste des sections'   AS title, 
    'View'           AS markdown,
    TRUE             AS sort, 
    TRUE             AS search;

SELECT       
   section_id                  AS Id,
   section_category            AS Catégorie,
   section_number              AS NoChrono,
   section_status              AS Publication,
   section_title               AS Titre,
  '[Edit](/a_info/section_help_edit_5.sql?section_id=' || section_id || ')&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Delete](/a_info/section_help_delete_0.sql?section_id=' || section_id|| ')'    AS View
FROM info_sections
WHERE section_status !='archived' AND section_category='help_dev'

ORDER BY section_category ASC, cast(section_number AS int)  ASC ;
