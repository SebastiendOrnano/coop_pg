SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_3.sql') AS properties;

SET prm2_id = SELECT prm2_id FROM prm2_sub WHERE prm2_sub_id = $prm2_sub_id::INTEGER;
set prm2_sub_name = (SELECT UPPER(prm2_sub_name) FROM prm2_sub WHERE prm2_sub_id = $prm2_sub_id::INTEGER);

SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion éditeur'         AS title,
    '/a_panels/panel_editor_3.sql' AS link;
SELECT 
    'Gestion des organisations'            AS title,
    '/d_prm2/prm2_main_display_3.sql'      AS link;
SELECT 
    'Gestion des filiales'            AS title,
    '/d_prm2_sub/prm2_sub_main_display_3.sql?prm2_id='||$prm2_id     AS link;
SELECT 
    'Gestion d''une filiale'            AS title,
    '/d_prm2_sub/prm2_sub_main_display_3.sql?prm2_id='||$prm2_id   AS link;
SELECT 
    'Gestion des docs d''une filiale'            AS title,
    '/d_prm2_sub_doc/prm2_sub_doc_main_display_3.sql?prm2_sub_id='||$prm2_sub_id   AS link;


SELECT 
    'datagrid'              AS component,
    'panel_prm2_sub_doc_display' AS id,
    'Traitement sur une selection de documents' AS title;
SELECT 
    '/d_prm2_sub_doc/prm2_sub_doc_select_all_0.sql?prm2_sub_id='||$prm2_sub_id      AS link,
    'Tout sélectionner'                                      AS description,
    'list-check'                                     AS icon,
    'red'                                               AS color;
SELECT 
    '/d_prm2_sub_doc/prm2_sub_doc_select_no_0.sql?prm2_sub_id='||$prm2_sub_id     AS link,
    'Annuler toute la sélection'               AS description,
    'stack'                                    AS icon,
    'red'                                   AS color;
SELECT 
    '/d_prm2_sub_doc/prm2_sub_doc_select_edit_3.sql?prm2_sub_id='||$prm2_sub_id     AS link,
    'Actualiser des données sur les doc sélectionnés'       AS description,
    'refresh'                                  AS icon,
    'blue'                                   AS color;


SELECT 
    'table'                 AS component, 
    'Liste des documents'   AS title, 
    'View'                  AS markdown,
    'Titre'                  AS markdown,
    'download_selection_table' AS id,
    TRUE                   AS sort, 
    TRUE                   AS search;

SELECT  
    prm2_sub_doc_id        AS Id,
    '['||prm2_sub_doc_title||']('||prm2_sub_doc_url||')'    AS Titre,
    prm2_sub_doc_status    AS statut,
    prm2_sub_doc_selected  AS selected,
  '[select / unselect](prm2_sub_doc_select_yes_0.sql?prm2_sub_doc_id='||prm2_sub_doc_id||'&prm2_sub_id='||$prm2_sub_id||')'    AS View
FROM prm2_sub_docs
WHERE prm2_sub_id = $prm2_sub_id::INTEGER
ORDER BY created_at DESC;




