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
    'Rèles actives'         AS title,
    '/a_choices/regex_main_display_5.sql' AS link;




-- Display list of organizations
SELECT 'table' AS component, 
    'Liste des règles'           AS title, 
    '/a_choices/regex_main_edit_5.sql?regex_id=={id}' as edit_url,
    '/a_choices/regex_main_delete_0.sql?regex_id=={id}' as delete_url,
    TRUE                        AS sort, 
    TRUE                        AS search;

SELECT
    regex_id                  AS Id,
    regex_id                  as _sqlpage_id,
    regex_name                 AS Label,
    regex_value              AS Value,
    regex_description              AS Description
FROM regex
WHERE regex_name IS NOT NULL AND regex_status !='active'
ORDER BY regex_name  ASC;
