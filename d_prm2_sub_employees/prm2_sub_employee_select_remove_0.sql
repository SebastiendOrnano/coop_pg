SET nb_employees_selected = SELECT COUNT(*) FROM prm2_sub_employees  WHERE employee_selected=true prm2_sub_id = $prm2_sub_id::INTEGER;

DELETE FROM prm2_sub_employees  WHERE employee_selected=true;

UPDATE prm2_sub
SET 
prm2_sub_nb_employees = prm2_sub_nb_employees-$nb_employees_selected::INTEGER,
updated_at=CURRENT_TIMESTAMP
WHERE prm2_sub_id = $prm2_sub_id::INTEGER

SELECT 
    'redirect' as component,
    '/d_prm2_sub_employees/prm2_sub_employee_select_display_4.sql?prm2_sub_id='||$prm2_sub_id   as link:

