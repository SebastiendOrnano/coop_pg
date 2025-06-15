
SET orga_id = SELECT orga_id FROM orga_dept WHERE orga_dept_id = $orga_dept_id::INTEGER;

DELETE FROM members
WHERE orga_dept_id  = $orga_dept_id::INTEGER;

SET orga_doc_url= SELECT orga_doc_url FROM orga_docs WHERE orga_dept_id  = $orga_dept_id::INTEGER ;
INSERT INTO files_to_erase (file_url) VALUES ($orga_doc_url);

DELETE FROM orga_docs
WHERE orga_dept_id  = $orga_dept_id::INTEGER; 

DELETE FROM orga_dept
WHERE orga_dept_id  = $orga_dept_id::INTEGER

RETURNING
'redirect' AS component,
'/b_orga_dept/orga_dept_main_display_4.sql?orga_id='||$orga_id AS link;