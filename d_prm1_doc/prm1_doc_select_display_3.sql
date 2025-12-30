SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_3.sql') AS properties;

SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion éditeur'         AS title,
    '/a_panels/panel_editor.sql' AS link;
SELECT 
    'Gestion des docs d''une personne'            AS title,
    '/d_prm1_doc/prm1_doc_main_display_3.sql?prm1_id='||$prm1_id     AS link;

SELECT 
    'datagrid'              AS component,
    'panel_prm1_doc_display' AS id,
    'Traitement sur une selection de documents' AS title;

SELECT 
    '/d_prm1_doc/prm1_doc_select_all_0.sql?prm1_id='||$prm1_id     AS link,
    'Tout sélectionner'                                      AS description,
    'list-check'                                     AS icon,
    'red'                                               AS color;
    
SELECT 
    '/d_prm1_doc/prm1_doc_select_no_0.sql?prm1_id='||$prm1_id     AS link,
    'Annuler toute la sélection'               AS description,
    'stack'                                    AS icon,
    'red'                                   AS color;

SELECT 
    '/d_prm1_doc/prm1_doc_select_edit_3.sql?prm1_id='||$prm1_id     AS link,
    'Actualiser des données sur les doc sélectionnés'       AS description,
    'refresh'                                  AS icon,
    'blue'                                   AS color;


-- table de sélection des membres 

SELECT 
    'table'                 AS component, 
    'Liste des documents'   AS title, 
    'View'                  AS markdown,
    'Titre'                  AS markdown,
    'download_selection_table' AS id,
    TRUE                   AS sort, 
    TRUE                   AS search;

SELECT  
    prm1_doc_id                                     AS Id,
    '['||prm1_doc_title||']('||prm1_doc_url||')'    AS Titre,
    prm1_doc_status                                 AS Statut,
    prm1_doc_selected                               AS selected,
  '[select / unselect](prm1_doc_select_yes_0.sql?prm1_doc_id=' || prm1_doc_id ||'&prm1_id='||$prm1_id||')'    AS View
FROM prm1_doc
ORDER BY created_at DESC;




