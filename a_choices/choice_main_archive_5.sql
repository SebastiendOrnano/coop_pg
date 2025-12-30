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
    'datagrid'              AS component,
    'panel_choice_display' AS id,
    'Gestion des listes de choix' AS title;
SELECT 
    '/a_choices/choice_category_display_5.sql'         AS link,
    'Liste des categories'                             AS description,
    'list-details'                                     AS icon,
    'green'                                            AS color;
SELECT 
    '/a_choices/choice_main_form_5.sql'     AS link,
    'Création d''un nouveau choix'                  AS description,
    'list-check'                                      AS icon,
    'yellow'                                         AS color;
SELECT 
     '/a_choices/choice_main_archive_5.sql'             AS link,
    'Visualiser les choix archivés'           AS description,
    'archive'                                     AS icon,
    'green'                                              AS color;


-- Display list of organizations
SELECT 'table' AS component, 
    'Liste des choix'           AS title, 
    '/a_choices/choice_main_edit_5.sql?choice_id={id}' as edit_url,
    '/a_choices/choice_main_delete_0.sql?choice_id={id}' as delete_url,
    TRUE                        AS sort, 
    TRUE                        AS search;

SELECT
    i.choice_id                  AS Id,
    i.choice_id                  as _sqlpage_id,
    i.choice_label               AS Label,
    i.choice_value               AS Value,
    c.choice_category_name       AS Categorie
    FROM choices_items AS i
LEFT JOIN (SELECT choice_category_name, choice_category_id FROM choices_categories) AS c
on i.choice_category_id = c.choice_category_id
WHERE i.choice_label IS NOT NULL AND i.choice_status ='archived'
ORDER BY c.choice_category_name  ASC;
