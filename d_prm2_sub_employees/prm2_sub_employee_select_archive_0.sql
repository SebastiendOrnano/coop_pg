

SET nb_employees_selected = SELECT COUNT(*) FROM prm2_sub_employees WHERE employee_selected=true;

UPDATE prm2_sub_employees 
SET
employee_status='archived',
updated_at=CURRENT_TIMESTAMP
WHERE employee_selected=true;

UPDATE prm2_sub
SET 
prm2_sub_nb_employees = prm2_sub_nb_employees-$nb_employees_selected::INTEGER,
updated_at=CURRENT_TIMESTAMP
WHERE prm2_sub_id = $prm2_sub_id::INTEGER

UPDATE prm1
SET 
prm1_status='archived'
FROM  prm1 as p
LEFT JOIN (SELECT prm1_id, employee_id, employee_selected FROM prm2_sub_employees) as e
ON p.prm1_id = e.prm1_id
WHERE e.employee_selected=true;

UPDATE prm1_doc
SET 
prm1_doc_status='archived'
FROM  prm1_doc as d
LEFT JOIN (SELECT prm1_id FROM prm1) as p
ON d.prm1_id = p.prm1_id
LEFT JOIN (SELECT prm1_id, employee_id, employee_selected FROM prm2_sub_employees) as e
ON p.prm1_id = e.prm1_id
WHERE e.employee_selected=true;

SELECT 
    'redirect' as component,
    '/d_prm2_sub_employees/prm2_sub_employee_main_display_4.sql?prm2_sub_id='||$prm2_sub_id    as link: