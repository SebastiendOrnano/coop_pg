SET prm2_sub_id = SELECT prm2_sub_id FROM prm2_sub_employees WHERE employee_id = $employee_id::INTEGER;
SET prm2_id = SELECT prm2_id FROM prm2_sub WHERE prm2_sub_id = $prm2_sub_id::INTEGER ;
SET prm1_id = SELECT prm1_id FROM prm2_sub_employees WHERE employee_id=$employee_id::INTEGER;

SET anonymous1=  SELECT(sqlpage.random_string(8));
SET anonymous2=  SELECT(sqlpage.random_string(8));
SET anonymous3=  SELECT(sqlpage.random_string(8));

UPDATE prm2_sub_employees 
SET
employee_status='archived',
updated_at=CURRENT_TIMESTAMP
WHERE employee_id=$employee_id::INTEGER;

UPDATE prm2_sub
SET 
prm2_sub_nb_employees = prm2_sub_nb_employees-1,
updated_at=CURRENT_TIMESTAMP
WHERE prm2_sub_id = $prm2_sub_id::INTEGER

DELETE FROM prm1_doc  WHERE prm1_id=$prm1_id::INTEGER;

UPDATE prm1
SET
   prm1_first_name=$anonymous1, 
   prm1_last_name=$anonymous2, 
   prm1_phone='000000',
   prm1_email=$anonymous3||'@noWHERE.com',
prm1_status='archived',
updated_at=CURRENT_TIMESTAMP
WHERE prm1_id=$prm1_id::INTEGER;

SELECT 
    'redirect' as component,
    '/d_prm2_sub_employees/prm2_sub_employee_main_display_4.sql?prm2_sub_id='||$prm2_sub_id    as link: