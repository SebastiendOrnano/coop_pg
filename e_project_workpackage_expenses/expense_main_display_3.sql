SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_3.sql') AS properties;

set workpackage_name = SELECT workpackage_name FROM project_workpackage WHERE workpackage_id = $workpackage_id::INTEGER ;
set project_id = SELECT project_id FROM project_workpackage WHERE workpackage_id = $workpackage_id::INTEGER ;


SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion éditeur'         AS title,
    '/a_panels/panel_editor_3.sql' AS link;
SELECT 
    'Projets'            AS title,
    '/e_project/project_main_display_3.sql'   AS link;   
 SELECT 
    'Hub projet'            AS title,
    '/e_project/project_hub_display_3.sql?project_id='||$project_id     AS link;   
SELECT 
    'Hub lot de travaux'            AS title,
    '/e_project_workpackage/workpackage_hub_display_3.sql?workpackage_id='||$workpackage_id    AS link;


SELECT 
    'datagrid'              AS component,
    'panel_project_display' AS id;
SELECT 
    '/e_project_workpackage_expenses/expense_main_form_3.sql?workpackage_id='||$workpackage_id     AS link,
    'Création d''une dépense'                  AS description,
    'tax-euro'                                      AS icon,
    'yellow'                                         AS color;

SELECT 
    '/e_project_workpackage_expenses/expense_csv_0.sql?workpackage_id='||$workpackage_id             AS link,
    'Télécharger les dépenses les dépenses achivées'           AS description,
    'download'                                                 AS icon,
    'blue'                                                    AS color;

SELECT 
    'divider' AS component,
    'Liste des dépenses du lot de travaux : '||$workpackage_name    AS contents,
    'blue' AS color;

SELECT 
    'table'               AS component, 
    FALSE                AS freeze_footers,
    'Liste des dépenses du lot de travaux : '||$workpackage_name AS title, 
    TRUE                  AS sort, 
    TRUE                AS search;

SELECT
    e.expense_id                     AS Id,
    e.expense_name                     AS Nom,
    e.expense_invoice_date             AS Date,
    e.expense_category                  AS Type,
    e.expense_value                     AS Price,
    p.prm2_name                         AS Fournisseur,
CASE
    WHEN e.expense_invoice_url !=''
    THEN JSON('{"name":"Facture","tooltip":"facture","link":"'|| e.expense_invoice_url||'","icon":"receipt-euro"}') 
    ELSE JSON('{"name":"Facture"}')
    END as _sqlpage_actions,
    JSON( '{"name":"Edit","tooltip":"edit","link":"/e_project_workpackage_expenses/expense_main_edit_4.sql?expense_id='||e.expense_id||'","icon":"edit"}') AS _sqlpage_actions
FROM project_workpackage_expenses AS e
LEFT JOIN (SELECT prm2_id, prm2_name FROM prm2) AS p
on e.provider_id = p.prm2_id
LEFT JOIN (SELECT workpackage_id, workpackage_name, workpackage_type, project_id FROM project_workpackage) AS w
ON e.workpackage_id=w.workpackage_id
WHERE e.expense_status='active' and w.workpackage_id=$workpackage_id::INTEGER;

SELECT 
    ''                        AS Id,
    ''                        AS Nom,
    ''                        AS Date,
    'TOTAL'                   AS Type,
    SUM(e.expense_value )     AS value,
    true                      AS _sqlpage_footer
    FROM project_workpackage_expenses AS e
LEFT JOIN (SELECT prm2_id, prm2_name FROM prm2) AS p
on e.provider_id = p.prm2_id
LEFT JOIN (SELECT workpackage_id, workpackage_name, workpackage_type, project_id FROM project_workpackage) AS w
ON e.workpackage_id=w.workpackage_id
WHERE e.expense_status='active' and w.workpackage_id=$workpackage_id::INTEGER;

