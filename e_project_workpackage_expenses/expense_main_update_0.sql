
set workpackage_id = SELECT workpackage_id FROM project_workpackage_expenses WHERE expense_id=$expense_id::INTEGER;

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


SET expense_value_old = SELECT expense_value FROM project_workpackage_expenses WHERE expense_id=$expense_id::INTEGER;
SET expense_value_new = :expense_value::NUMERIC;
SET expense_delta =  $expense_value_new::NUMERIC - $expense_value_old::NUMERIC ;


UPDATE project_workpackage_expenses 
SET 
expense_name=:expense_name,
expense_status=:expense_status,
expense_summary=:expense_summary,
expense_category=:expense_category,
expense_invoice_date=	COALESCE(NULLIF(:expense_invoice_date, ''), NULL)::DATE,
expense_unit=:expense_unit,
expense_value=COALESCE(NULLIF(:expense_value, ''), NULL)::NUMERIC,
provider_id=COALESCE(NULLIF(:provider_id, ''), NULL)::INTEGER,
updated_at = CURRENT_TIMESTAMP
WHERE expense_id = $expense_id::INTEGER



UPDATE project_workpackage
SET
workpackage_cost_actual= workpackage_cost_actual + $expense_delta::NUMERIC
WHERE workpackage_id=$workpackage_id::INTEGER


RETURNING 'redirect' AS component,
$redirect_link  AS link;






RETURNING 'redirect' AS component,
$redirect_link AS link;


