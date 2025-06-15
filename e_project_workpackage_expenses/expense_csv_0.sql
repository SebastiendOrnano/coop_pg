SELECT
    'csv'                       AS component,
    'Télécharger les dépenses'  AS title,
    'depenses'                  AS filename,
    'csv'                       AS class,
    'file-download'             AS icon,
    'yellow'                    AS color,
    ';'                         AS separator,
    TRUE                        AS bom;

SELECT
    p.project_id            AS ProjectId,
    p.project_name          AS ProjectName,
    w.workpackage_id        AS WKPId,
    w.workpackage_name      AS WKPName,
    e.expense_invoice_date  AS DateDepense,
    e.expense_id            AS ExpenseId,
    e.expense_name          AS ExpenseName,
    e.expense_value         AS Montant,
    e.expense_tax_rate      AS Tax,
    e.expense_category      AS Category
FROM project_workpackage_expenses AS e
LEFT JOIN (SELECT workpackage_id, workpackage_name, project_id FROM project_workpackage ) AS w
ON e.workpackage_id = w.workpackage_id
LEFT JOIN (SELECT project_id, project_name FROM project) AS p
ON p.project_id = w.project_id
WHERE e.workpackage_id =$workpackage_id::INTEGER AND e.expense_status= 'active';
