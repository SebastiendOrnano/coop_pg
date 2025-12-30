UPDATE orga_dept_docs 
SET orga_doc_selected = TRUE

RETURNING 
'redirect' AS component, 
'/b_orga_dept_doc/orga_dept_doc_select_display_4.sql?orga_dept_id='||$orga_dept_id AS link;


