SET prm2_id = SELECT prm2_id FROM prm2_sub WHERE prm2_sub_id = $prm2_sub_id::INTEGER;

SET user_role = (
    SELECT user_role FROM users
    INNER JOIN sessions ON users.user_id = sessions.user_id
    WHERE sessions.session_token = sqlpage.cookie('session_token')
); 

SET redirect_link =
    CASE WHEN $user_role = 'supervisor' 
    THEN '/d_prm2_sub_employees/prm2_sub_employee_main_display_4.sql?prm2_sub_id='||$prm2_sub_id||'&prm2_id='||$prm2_id
    ELSE '/d_prm2_sub_employees/prm2_sub_employee_main_display_3.sql?prm2_sub_id='||$prm2_sub_id||'&prm2_id='||$prm2_id
END;

INSERT INTO prm2_sub_employees
(
prm1_id,
prm2_sub_id,
employee_title,
employee_function,
employee_category,
employee_status,
employee_since
)
VALUES
(
$prm1_id::INTEGER,
$prm2_sub_id::INTEGER,
:employee_title,
:employee_function,
:employee_category,
'active',
:employee_since::DATE
);

UPDATE prm2_sub
SET 
prm2_sub_nb_employees = prm2_sub_nb_employees+1,
updated_at=CURRENT_TIMESTAMP
WHERE prm2_sub_id = $prm2_sub_id::INTEGER

SELECT 'redirect' as component,
$redirect_link as link;


