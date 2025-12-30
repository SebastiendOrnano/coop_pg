SET orga_dept_id = SELECT orga_dept_id FROM orga_dept_docs WHERE orga_doc_id=$orga_doc_id::INTEGER;

UPDATE orga_dept_docs 
SET orga_doc_selected = 
(CASE 
    WHEN orga_doc_selected =true THEN false
    ELSE true END)
WHERE orga_doc_id = $orga_doc_id::INTEGER

RETURNING 
'redirect' AS component, 
'/b_orga_dept_doc/orga_dept_doc_select_display_4.sql?orga_dept_id='||$orga_dept_id AS link;


