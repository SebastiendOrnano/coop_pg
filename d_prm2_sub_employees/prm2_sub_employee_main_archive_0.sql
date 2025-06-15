
SET prm2_sub_id = SELECT prm2_sub_id FROM prm2_sub_employees WHERE employee_id = $employee_id::INTEGER;


UPDATE prm2_sub_employees
SET employee_status='archived'
WHERE employee_id=$employee_id::INTEGER;

UPDATE prm2_sub
SET 
prm2_sub_nb_employees = prm2_sub_nb_employees-1,
updated_at=CURRENT_TIMESTAMP
WHERE prm2_sub_id = $prm2_sub_id::INTEGER

SELECT 
    'redirect' as component,
    '/d_prm2_sub_employees/prm2_sub_employee_main_display_4.sql?prm2_sub_id='||$prm2_sub_id    as link:

