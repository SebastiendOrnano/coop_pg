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
    'Catégories actives'            AS title,
    '/a_choices/choice_category_display_5.sql'      AS link;




-- Display list of organizations
SELECT 'table' AS component, 
    'Liste des categories'   AS title, 
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
WHERE choice_category_name IS NOT NULL AND choice_category_status ='archived'
ORDER BY choice_category_name  ASC;
