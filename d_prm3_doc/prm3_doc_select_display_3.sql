SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_3.sql') AS properties;

SELECT 
    'breadcrumb' as component;
SELECT 
    'Home' as title,
    '/'    as link;
SELECT 
    'Gestion éditeur'         as title,
    '/a_panels/panel_editor_3.sql' as link;
SELECT 
    'Gestion des groupements'            as title,
    '/d_prm3/prm3_main_display_3.sql'      as link;

SELECT 
    'datagrid'              as component,
    'panel_prm3_doc_display' as id,
    'Traitement sur une selection de documents' as title;

SELECT 
    '/d_prm3_doc/prm3_doc_select_all_0.sql?prm3_id='||$prm3_id     as link,
    'Tout sélectionner'                                      as description,
    'list-check'                                     as icon,
    'red'                                               as color;

SELECT 
    '/d_prm3_doc/prm3_doc_select_no_0.sql?prm3_id='||$prm3_id     as link,
    'Annuler toute la sélection'               as description,
    'stack'                                    as icon,
    'red'                                   as color;

SELECT 
    '/d_prm3_doc/prm3_doc_select_edit_3.sql?prm3_id='||$prm3_id     as link,
    'Actualiser des données sur les doc sélectionnés'       as description,
    'refresh'                                  as icon,
    'blue'                                   as color;


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
    prm3_doc_id                                     AS Id,
    '['||prm3_doc_title||']('||prm3_doc_url||')'    AS Titre,
    prm3_doc_status                                 AS Statut,
    prm3_doc_selected                               AS selected,
  '[select / unselect](prm3_doc_select_yes_0.sql?prm3_doc_id=' || prm3_doc_id ||'&prm3_id='||$prm3_id||')'    AS View
FROM prm3_docs
ORDER BY created_at DESC;




