UPDATE orga_docs 
SET orga_doc_selected = false

RETURNING 'redirect' AS component, 
'/b_orga_dept_doc/orga_dept_doc_main_display_4.sql?orga_dept_id='||$orga_dept_id  as link;


