set prm2_sub_id = SELECT prm2_sub_id FROM prm2_sub_employees WHERE employee_id = $employee_id::INTEGER;
set prm1_id = SELECT prm1_id FROM prm2_sub_employees WHERE employee_id = $employee_id::INTEGER;

SET user_role = (
    SELECT user_role FROM users
    INNER JOIN sessions ON users.user_id = sessions.user_id
    WHERE sessions.session_token = sqlpage.cookie('session_token')
); 

SET redirect_link =
CASE WHEN $user_role = 'supervisor' 
THEN '/d_prm2_sub_employees/prm2_sub_employee_main_display_4.sql?prm2_sub_id='||$prm2_sub_id
ELSE '/d_prm2_sub_employees/prm2_sub_employee_main_display_3.sql?prm2_sub_id='||$prm2_sub_id
END;

UPDATE prm1
SET
prm1_first_name = :prm1_first_name,
prm1_last_name= :prm1_last_name,

    prm1_gender = CASE 
    WHEN :prm1_gender IS NULL OR :prm1_gender = '' 
    THEN prm1_gender
    ELSE :prm1_gender END,

    prm1_category = CASE 
    WHEN :prm1_category IS NULL OR :prm1_category = '' 
    THEN prm1_category
    ELSE :prm1_category END,

    prm1_function = CASE 
    WHEN :prm1_function IS NULL OR :prm1_function = '' 
    THEN prm1_function
    ELSE :prm1_function END,
prm1_phone = :prm1_phone, 
prm1_email = :prm1_email,
prm1_date_birthday=COALESCE(NULLIF(:prm1_date_birthday, ''), NULL)::DATE, 
prm1_cv_short = :prm1_cv_short, 
prm1_cv_long = :prm1_cv_long,
updated_at = CURRENT_TIMESTAMP
WHERE prm1_id =  $prm1_id::INTEGER

RETURNING  'redirect' AS component,
$redirect_link AS link;


