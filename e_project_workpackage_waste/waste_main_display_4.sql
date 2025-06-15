SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

set workpackage_name = SELECT workpackage_name FROM project_workpackage WHERE workpackage_id = $workpackage_id::INTEGER ;
SET project_id = SELECT project_id FROM project_workpackage WHERE workpackage_id=$workpackage_id::INTEGER;

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
    'datagrid'              AS component,
    'panel_project_display' AS id;
SELECT 
    '/e_project_workpackage_waste/waste_main_form_step1_4.sql?workpackage_id='||$workpackage_id      AS link,
    'Création d''un déchet'                  AS description,
    'trash'                                      AS icon,
    'yellow'                                         AS color;
SELECT 
    '/e_project_workpackage_waste/waste_archive_display_4.sql?workpackage_id='||$workpackage_id           AS link,
    'Visualiser les déchets achivées'           AS description,
    'archive'                                     AS icon,
    'green'                                              AS color;



SELECT 
    'divider' AS component,
    'Liste des déchets sur le de travaux : '||$workpackage_name    AS contents,
    'blue' AS color;

SELECT 
    'table'               AS component, 
    'Liste des déchets sur le de travaux : '||$workpackage_name AS title, 
    TRUE                  AS sort, 
    'View'                AS markdown,
    'Inv'                AS markdown, 
    FALSE                 AS search;

SELECT
    m.waste_id                     AS Id,
    m.waste_name                   AS Nom,
    c.product_category_name        AS Catégorie,
    m.waste_quantity               AS Quantité,
    m.waste_value||'  €'           AS Value,
    p.prm2_name                    AS Récupérateur,
'[Edit](/e_project_workpackage_waste/waste_main_edit_4.sql?waste_id=' 
||m.waste_id|| 
') &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [Delete](/e_project_workpackage_waste/waste_main_delete_alert_4.sql?waste_id=' 
||m.waste_id||
')'    AS View
FROM project_workpackage_waste AS m
LEFT JOIN (SELECT prm2_id, prm2_name FROM prm2) AS p
on m.recipiend_id = p.prm2_id
LEFT JOIN (SELECT product_category_id, product_category_name FROM project_products_categories) AS c
on c.product_category_id = m.waste_category_id
LEFT JOIN (SELECT workpackage_id FROM project_workpackage) AS w
on w.workpackage_id=m.workpackage_id
WHERE m.waste_status='active' and w.workpackage_id=$workpackage_id::INTEGER;

SELECT 
    ''                            AS Id,
    'TOTAL'                       AS Nom,
    ''                             AS Catégorie,
   ''                              AS Quantité,
    SUM(m.waste_value)||'  €'      AS value,
    true                      AS _sqlpage_footer
FROM project_workpackage_waste AS m
LEFT JOIN (SELECT prm2_id, prm2_name FROM prm2) AS p
on m.recipiend_id = p.prm2_id
LEFT JOIN (SELECT product_category_id, product_category_name FROM project_products_categories) AS c
on c.product_category_id = m.waste_category_id
LEFT JOIN (SELECT workpackage_id FROM project_workpackage) AS w
on w.workpackage_id=m.workpackage_id
WHERE m.waste_status='active' and w.workpackage_id=$workpackage_id::INTEGER;

