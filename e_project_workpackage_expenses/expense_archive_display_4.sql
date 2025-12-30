SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

set project_id = SELECT project_id FROM project_workpackage WHERE workpackage_id=$workpackage_id::INTEGER;

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
    '/e_project/project_main_display_4.sql'   AS link;
 SELECT 
    'Hub projet'            AS title,
    '/e_project/project_hub_display_4.sql?project_id='||$project_id   AS link;
 SELECT 
    'Hub lot de travaaux'            AS title,
    '/e_project_workpackage/workpackage_hub_display_4.sql?workpackage_id='||$workpackage_id   AS link;    
SELECT 
    'Gestion des dépenses actives'            AS title,
    '/e_project_workpackage_expenses/expense_main_display_4.sql?workpackage_id='||$workpackage_id     AS link;


SELECT 
    'divider' AS component,
    'Base des dépenses archivées'    AS contents,
    'blue' AS color;

SELECT 
    'table'               AS component, 
    FALSE                 AS freeze_footers,
    'Liste des dépenses du lot de travaux : '||$workpackage_name AS title, 
    TRUE                  AS sort, 
    TRUE                 AS search;

SELECT
    e.expense_id                     AS Id,
    e.expense_id                     AS _sqlpage_id,
    e.expense_name                     AS Nom,
    e.expense_invoice_date             AS Date,
    e.expense_category                  AS Type,
    e.expense_value                     AS Price,
    p.prm2_name                         AS Fournisseur,
CASE
    WHEN e.expense_invoice_url !=''
    THEN JSON('{"name":"Facture","tooltip":"facture","link":"'||e.expense_invoice_url||'","icon":"receipt-euro"}') 
    ELSE JSON('{"name":"Facture"}')
    END as _sqlpage_actions,
    JSON( '{"name":"Edit","tooltip":"edit","link":"/e_project_workpackage_expenses/expense_main_edit_4.sql?expense_id='||e.expense_id||'","icon":"edit"}') AS _sqlpage_actions,
    JSON('{"name":"Delete","tooltip":"Supprimer une dépense","link":"/e_project_workpackage_expenses/expense_main_delete_alert_4.sql?expense_id='||e.expense_id||'","icon":"trash"}') as _sqlpage_actions
FROM project_workpackage_expenses AS e
LEFT JOIN (SELECT prm2_id, prm2_name FROM prm2) AS p
on e.provider_id = p.prm2_id
LEFT JOIN (SELECT workpackage_id, workpackage_name, workpackage_type, project_id FROM project_workpackage) AS w
ON e.workpackage_id=w.workpackage_id
WHERE e.expense_status!='active' and w.workpackage_id=$workpackage_id::INTEGER;