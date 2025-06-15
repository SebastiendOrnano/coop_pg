SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SET orga_dept_name = SELECT orga_dept_name FROM orga_dept WHERE orga_dept_id=$orga_dept_id::INTEGER;


SELECT 
    'breadcrumb' as component;
SELECT 
    'Home' as title,
    '/'    as link;
SELECT 
    'Gestion Superviseur'         as title,
    '/a_panels/panel_supervisor_4.sql' as link;
SELECT 
    'Gestion des documents institutionnels'            as title,
     '/b_orga_dept_doc/orga_dept_doc_selector_4.sql'  as link;
SELECT 
    'Gestion des documents de la structure'            as title,
    '/b_orga_dept_doc/orga_dept_doc_main_display_4.sql?orga_dept_id='||$orga_dept_id       as link;

SELECT 
    'datagrid'              as component,
    'panel_orga_doc_display' as id,
    'Traitement sur une selection de documents de la structure : '||$orga_dept_name as title;

SELECT 
    '/b_orga_dept_doc/orga_dept_doc_select_all_0.sql?orga_dept_id='||$orga_dept_id    as link,
    'Tout sélectionner'                       as description,
    'toggle-left'                                    as icon,
    'green'                                      as color;


SELECT 
    '/b_orga_dept_doc/orga_dept_doc_select_no_0.sql?orga_dept_id='||$orga_dept_id     as link,
    'Annuler toute la sélection'               as description,
    'toggle-right'                                    as icon,
    'red'                                   as color;

SELECT 
    '/b_orga_dept_doc/orga_dept_doc_select_edit_4.sql?orga_dept_id='||$orga_dept_id     as link,
    'Actualiser des données sur les doc sélectionnés'       as description,
    'refresh'                                  as icon,
    'blue'                                   as color;

SELECT 
    '/b_orga_dept_doc/orga_dept_doc_select_delete_0.sql?orga_dept_id='||$orga_dept_id    as link,
    'Supprimer les doc sélectionnés'       as description,
    'books'                                    as icon,
    'yellow'                                   as color;



-- table de sélection des membres 

SELECT 
    'table'                 AS component, 
    'Liste des documents'   AS title, 
    'View'                  AS markdown,
    'Titre'                  AS markdown,
    'download_selection_table' as id,
    TRUE                   AS sort, 
    TRUE                   AS search;

SELECT  
    orga_doc_id        AS Id,
    '['||orga_doc_title||']('||orga_doc_url||')'    AS Titre,
    orga_doc_edition    AS Edition,
    orga_doc_status   AS Publication,
    orga_doc_selected  AS selected,
  '[select / unselect](/b_orga_dept_doc/orga_dept_doc_select_yes_0.sql?orga_doc_id=' || orga_doc_id ||')'    AS View
FROM orga_docs
WHERE orga_doc_status!='archived' AND orga_dept_id=$orga_dept_id::INTEGER
ORDER BY created_at DESC;




