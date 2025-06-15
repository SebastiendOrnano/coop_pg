SET user_role = (
    SELECT user_role FROM users
    INNER JOIN sessions ON users.user_id = sessions.user_id
    WHERE sessions.session_token = sqlpage.cookie('session_token')
); 

SET redirect_link =
CASE WHEN $user_role = 'supervisor' 
THEN '/d_prm2_sub_employees/prm2_sub_employee_select_no_0.sql?prm2_sub_id='||$prm2_sub_id
ELSE '/d_prm2_sub_employees/prm2_sub_employee_select_no_0.sql?prm2_sub_id='||$prm2_sub_id
END;


UPDATE prm2_sub_employees
SET 
    employee_title = CASE 
    WHEN :employee_title IS NULL OR :employee_title = '' 
    THEN employee_title
    ELSE :employee_title END,

    employee_category = CASE 
    WHEN :employee_category IS NULL OR :employee_category = '' 
    THEN employee_category
    ELSE :employee_category END,

    employee_status = CASE 
    WHEN :employee_status IS NULL OR :employee_status = '' 
    THEN employee_status
    ELSE :employee_status END,

    employee_function = CASE 
    WHEN :employee_function IS NULL OR :employee_function = '' 
    THEN employee_function
    ELSE :employee_function END,

    employee_since = CASE 
    WHEN :employee_since IS NULL OR :employee_since = '' 
    THEN employee_since
    ELSE :employee_since::DATE END,

updated_at = CURRENT_TIMESTAMP
WHERE employee_selected = true AND prm2_sub_id=$prm2_sub_id::INTEGER
 
RETURNING  'redirect' AS component,
$redirect_link AS link;


