SET user_role = (
    SELECT user_role FROM users
    INNER JOIN sessions ON users.user_id = sessions.user_id
    WHERE sessions.session_token = sqlpage.cookie('session_token')
); 

SET redirect_link =
CASE WHEN $user_role = 'supervisor' 
THEN  '/e_project_workpackage_expenses/expense_main_display_4.sql?workpackage_id='||$workpackage_id 
ELSE  '/e_project_workpackage_expenses/expense_main_display_3.sql?workpackage_id='||$workpackage_id 
END;

INSERT INTO project_workpackage_expenses
(
	provider_id,
	workpackage_id,
	expense_name,
	expense_status,
	expense_invoice_url,
	expense_unit,
	expense_quantity,
	expense_category,
	expense_summary,
	expense_invoice_date,
	expense_value
	)
VALUES 
(
	COALESCE(NULLIF(:provider_id, ''), NULL)::INTEGER,
	$workpackage_id::INTEGER,
	:expense_name,
	'active',
	sqlpage.persist_uploaded_file('expense_invoice_url', 'x_docs', 'pdf,docx,jpg,jpeg,png,gif'),
	:expense_unit,
	COALESCE(NULLIF(:expense_quantity,''), NULL)::INTEGER,
	:expense_category,
	:expense_summary,
	COALESCE(NULLIF(:expense_invoice_date, ''), NULL)::DATE,
	COALESCE(NULLIF(:expense_value, ''), NULL)::NUMERIC(10,2)
);

UPDATE project_workpackage
SET
workpackage_cost_actual= COALESCE(NULLIF(workpackage_cost_actual , NULL), 0)::NUMERIC(10,2)+ :expense_value::NUMERIC
WHERE workpackage_id=$workpackage_id::INTEGER


RETURNING 'redirect' AS component,
$redirect_link  AS link;


