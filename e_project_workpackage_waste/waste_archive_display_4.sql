SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion Superviseur'         AS title,
    '/a_panels/panel_supervisor_4.sql' AS link;
 SELECT 
    'Projets'            AS title,
    '/e_project/project_main_display_4.sql'     AS link;
 SELECT 
    'Hub du projet'            AS title,
    '/e_project/project_hub_display_4.sql?project_id='||$project_id     AS link; 
SELECT 
    'Hub lot de travaux'    AS title,
    '/e_project_workpackage/workpackage_hub_display_4.sql?workpackage_id='||$workpackage_id AS link;
SELECT 
    'Déchets actifs'            AS title,
    '/e_project_workpackage_waste/waste_main_display_4.sql?workpackage_id='||$workpackage_id    AS link;



SELECT 
    'divider' AS component,
    'Base des matériaux archivés'    AS contents,
    'blue' AS color;

SELECT 
    'table'               AS component, 
    'Liste des matériaux' AS title, 
    TRUE                  AS sort, 
    FALSE                 AS search;

SELECT
    m.waste_id                     AS Id,
    m.waste_name                   AS Nom,
    c.product_category_name        AS Catégorie,
    m.waste_quantity               AS Quantité,
    m.waste_value||'  €'           AS Value,
    p.prm2_name                    AS Récupérateur,
    JSON( '{"name":"Edit","tooltip":"edit","link":"/e_project_workpackage_waste/waste_main_edit_4.sql?waste_id='||m.waste_id||'","icon":"edit"}') AS _sqlpage_actions,
    JSON('{"name":"Delete","tooltip":"Supprimer une dépense","link":"/e_project_workpackage_waste/waste_main_delete_alert_4.sql?waste_id='||m.waste_id||'","icon":"trash"}') as _sqlpage_actions
FROM project_workpackage_waste AS m
LEFT JOIN (SELECT prm2_id, prm2_name FROM prm2) AS p
on m.recipiend_id = p.prm2_id
LEFT JOIN (SELECT product_category_id, product_category_name FROM project_products_categories) AS c
on c.product_category_id = m.waste_category_id
LEFT JOIN (SELECT workpackage_id FROM project_workpackage) AS w
on w.workpackage_id=m.workpackage_id
WHERE m.waste_status='archived' and w.workpackage_id=$workpackage_id::INTEGER;

