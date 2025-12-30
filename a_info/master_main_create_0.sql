

UPDATE orga_dept 
SET orga_dept_master = NULL;

UPDATE orga_dept 
SET orga_dept_master = 'master'
WHERE orga_dept_id=:orga_dept_id::INTEGER

RETURNING  'redirect' AS component,
'/a_info/master_main_form1_5.sql' AS link;
