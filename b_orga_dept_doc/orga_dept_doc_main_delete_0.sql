SET orga_dept_id= SELECT orga_dept_id FROM orga_docs WHERE orga_doc_id=$orga_doc_id::INTEGER;

DELETE FROM orga_docs
WHERE orga_doc_id = $orga_doc_id::INTEGER
RETURNING
   'redirect' AS component,
   '/b_orga_dept_doc/orga_dept_doc_main_display_4.sql?orga_dept_id='||$orga_dept_id  as link;