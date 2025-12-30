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
    'Gestion des docs d''un groupement'            as title,
    '/d_prm3_doc/prm3_doc_main_display_4.sql?prm3_id='||$prm3_id     as link;

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
    '/d_prm3_doc/prm3_doc_select_edit_4.sql?prm3_id='||$prm3_id     as link,
    'Actualiser des données sur les doc sélectionnés'       as description,
    'refresh'                                  as icon,
    'blue'                                   as color;
SELECT 
    '/d_prm3_doc/prm3_doc_select_delete_0.sql?prm3_id='||$prm3_id    as link,
    'Supprimer les doc sélectionnés'       as description,
    'books'                                    as icon,
    'yellow'                                   as color;


-- table de sélection des membres 

SELECT 
    'table'                 AS component, 
    'Liste des documents'   AS title, 
    'View'                  AS markdown,
    'Titre'                  AS markdown,
    TRUE                   AS sort, 
    TRUE                   AS search;

SELECT  
    prm3_doc_id                                     AS Id,
    '['||prm3_doc_title||']('||prm3_doc_url||')'    AS Titre,
    prm3_doc_status                                 AS Statut,
    prm3_doc_selected                               AS selected,
  '[select/unselect](prm3_doc_select_yes_0.sql?prm3_doc_id='||prm3_doc_id||')'    AS View
FROM prm3_docs
ORDER BY created_at DESC;




