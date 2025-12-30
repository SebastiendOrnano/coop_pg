SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_5.sql') AS properties;

SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion admin'         AS title,
    '/a_panels/panel_admin_5.sql' AS link;
SELECT 
    'Gestion des choix'            AS title,
    '/a_choices/choice_main_display_5.sql'      AS link;


SELECT 
    'datagrid'              AS component,
    'panel_choice_display' AS id,
    'Gestion des catégories' AS title;

SELECT 
    '/a_choices/choice_category_form_5.sql'          AS link,
    'Création d''une nouvelle catégorie de choix'    AS description,
    'list-details'                                      AS icon,
    'yellow'                                         AS color;

SELECT 
     '/a_choices/choice_category_archive_5.sql'     AS link,
    'Visualiser les categories archivées'           AS description,
    'archive'                                       AS icon,
    'green'                                         AS color;


-- Display list of organizations
SELECT 'table' AS component, 
    'Liste des ocategories'   AS title, 
    '/a_choices/choice_category_edit_5.sql?choice_category_id={id}' as edit_url,
    '/a_choices/choice_category_delete_0.sql?choice_category_id=={id}' as delete_url,
    TRUE             AS sort, 
    TRUE             AS search;

SELECT
    choice_category_id               AS Id,
    choice_category_id              as _sqlpage_id,
    choice_category_name            AS Nom,
    choice_category_summary         AS Description
    FROM choices_categories
WHERE choice_category_name IS NOT NULL AND choice_category_status !='archived'
ORDER BY choice_category_name  ASC;
