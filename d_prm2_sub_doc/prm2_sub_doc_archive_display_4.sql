SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

set prm2_sub_name = (SELECT UPPER(prm2_sub_name) FROM prm2_sub WHERE prm2_sub_id = $prm2_sub_id::INTEGER);
set prm2_id = (SELECT prm2_id FROM prm2_sub WHERE prm2_sub_id = $prm2_sub_id::INTEGER);

SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion Superviseur'         AS title,
    '/a_panels/panel_supervisor_4.sql' AS link;
SELECT 
    'Gestion des organisations'            AS title,
    '/d_prm2/prm2_main_display_4.sql'      AS link;
SELECT 
    'Gestion des filiales'            AS title,
    '/d_prm2_sub/prm2_sub_main_display_4.sql?prm2_id='||$prm2_id     AS link;
SELECT 
    'Gestion d''une filiale'            AS title,
    '/d_prm2_sub/prm2_sub_main_display_4.sql?prm2_id='||$prm2_id   AS link;
SELECT 
    'Gestion des docs d''une filiale'            AS title,
    '/d_prm2_sub_doc/prm2_sub_doc_main_display_4.sql?prm2_sub_id='||$prm2_sub_id   AS link;



-- Display list of  docs

SELECT 'table' AS component, 
    'Liste des documents'   AS title,
    'Titre'           AS markdown,
    '/d_prm2_sub_doc/prm2_sub_doc_main_edit_4.sql?prm2_sub_doc_id={id}' as edit_url,
    '/d_prm2_sub_doc/prm2_sub_doc_main_delete_alert1_4.sql?prm2_sub_doc_id={id}' as delete_url,
    TRUE             AS sort, 
    TRUE             AS search;

SELECT
    prm2_sub_doc_id        AS Id,
    prm2_sub_doc_id        AS _sqlpage_id,
   '['||prm2_sub_doc_title||']('||prm2_sub_doc_url||')'    AS Titre,
   prm2_sub_doc_date_publication     AS Date_Pub,
   prm2_sub_doc_date_period          AS Period,
   prm2_sub_doc_category             AS Categorie,
   prm2_sub_doc_status              AS Statut
FROM prm2_sub_docs
WHERE prm2_sub_id = $prm2_sub_id::INTEGER AND prm2_sub_doc_status != 'active'
ORDER BY created_at DESC;
