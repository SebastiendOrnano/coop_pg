SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SELECT 
    'breadcrumb' as component;
SELECT 
    'Home' as title,
    '/'    as link;
SELECT 
    'Gestion Superviseur'         as title,
    '/a_panels/panel_supervisor_4.sql' as link;

SELECT 
    'datagrid'              as component,
    'panel_orga_doc_display' as id,
    'Gestion des documents institutionnels' as title;

SELECT 
    '/b_orga_dept_doc/orga_dept_doc_main_form_4.sql'          as link,
    'Création d''un nouveau document'          as description,
    'books'                                    as icon,
    'yellow'                                   as color;
SELECT 
    '/b_orga_dept_doc/orga_dept_doc_free_display_4.sql'          as link,
    'Documents non rattachés à une structure'    as description,
    'books'                                      as icon,
    'red'                                        as color;

SELECT 
    'form' as component,
    'Rechercher  les documents rattachés à une structure' as title,
    'Créer' as validate,
    'Clear' as reset,
    '/b_orga_dept_doc/orga_dept_doc_selector_0.sql' as action;

SELECT 
    'orga_dept_id' as name,
    'nom du département ou de la filiale' as label,
    'select' as type,
    12 AS width,
    TRUE       as required,
    'Selectionner une entreprise...' as empty_option,
   'Saisissez quelques lettres et choississez dans la liste' as description,
    json_agg(JSON_BUILD_OBJECT('label',o.orga_name||'('||o.orga_id||')--'||d.orga_dept_name||'('||d.orga_dept_id ||')', 'value', d.orga_dept_id)ORDER BY  o.orga_name ASC, d.orga_dept_name ASC)  AS options
    FROM orga_dept AS d
    LEFT JOIN orga AS o 
    ON d.orga_id = o.orga_id;

