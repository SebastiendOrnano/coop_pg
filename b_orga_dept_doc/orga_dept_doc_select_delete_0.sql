DELETE FROM orga_docs
WHERE orga_doc_selected = true

RETURNING 
'redirect' AS component, 
'/b_orga_dept_doc/orga_dept_doc_select_no_0.sql?orga_dept_id='||$orga_dept_id AS link;