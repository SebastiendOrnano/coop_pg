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
    'Base des matériaux archivés'    AS contents,
    'blue' AS color;

SELECT 
    'table'               AS component, 
    'Liste des matériaux' AS title, 
    TRUE                  AS sort, 
    'View'                AS markdown, 
    FALSE                 AS search;

SELECT
    m.expense_id              AS Id,
    m.expense_name            AS Nom,
    m.expense_category        AS Type,
    p.prm2_name                AS Fournisseur,
'[Edit](/e_project_workpackage_expenses/expense_main_edit_4.sql?expense_id=' 
||m.expense_id|| 
') &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [Delete](/e_project_workpackage_expenses/expense_main_delete_alert_4.sql?expense_id=' 
||m.expense_id||
')'    AS View
FROM project_workpackage_expenses AS m
LEFT JOIN (SELECT prm2_id, prm2_name FROM prm2) AS p
on m.provider_id = p.prm2_id
WHERE m.expense_status!='active'
ORDER BY m.expense_category ASC;

