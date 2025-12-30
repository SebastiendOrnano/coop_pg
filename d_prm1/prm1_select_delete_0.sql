UPDATE prm2_sub_employees
SET employee_selected = true
FROM   (select prm1_id  FROM prm1 WHERE prm1_selected = true) AS selection2
WHERE   prm2_sub_employees.prm1_id = selection2.prm1_id;

DELETE FROM prm2_sub_employees
WHERE employee_selected = true;

DELETE FROM prm3_participants WHERE prm1_id = $prm1_id::INTEGER;

DELETE FROM project_workpackage_participants WHERE prm1_id = $prm1_id::INTEGER;

DELETE FROM project_worksequence_participants WHERE prm1_id = $prm1_id::INTEGER;

UPDATE FROM prm1_doc
SET prm1_doc_selected = true
FROM   (select prm1_id  FROM prm1 WHERE prm1_selected = true) AS selection2
WHERE   prm1_doc.prm1_id = selection2.prm1_id;

INSERT INTO files_to_erase (file_url) 
select prm1_doc_url FROM prm1_doc
WHERE prm1_doc_selected=true;

DELETE FROM prm1_doc
WHERE prm1_doc_selected=true;

DELETE FROM prm1
WHERE prm1_selected = true
RETURNING
   'redirect' AS component,
   '/d_prm1/prm1_select_display_4.sql)' as link;