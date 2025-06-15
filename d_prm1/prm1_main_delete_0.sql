SET prm1_doc_url= SELECT prm1_doc_url FROM prm1_doc WHERE prm1_id  = $prm1_id::INTEGER ;
INSERT INTO files_to_erase (file_url) VALUES ($prm1_doc_url);

DELETE FROM prm2_sub_employees WHERE prm1_id = $prm1_id::INTEGER;

DELETE FROM prm3_participants WHERE prm1_id = $prm1_id::INTEGER;

DELETE FROM project_workpackage_participants WHERE prm1_id = $prm1_id::INTEGER;

DELETE FROM project_worksequence_participants WHERE prm1_id = $prm1_id::INTEGER;

DELETE FROM prm1_doc WHERE prm1_id  = $prm1_id::INTEGER;

DELETE FROM prm1 WHERE prm1_id = $prm1_id::INTEGER

RETURNING
   'redirect' AS component,
   '/d_prm1/prm1_main_display_4.sql' as link;