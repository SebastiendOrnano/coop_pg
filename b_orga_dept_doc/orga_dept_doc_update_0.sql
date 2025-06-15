UPDATE orga_docs
SET 
orga_dept_id=:orga_dept_id::INTEGER,
updated_at = CURRENT_TIMESTAMP
WHERE orga_doc_id = :orga_doc_id::INTEGER

SELECT 'redirect' AS component,
'/b_orga_dept/orga_dept_doc_main_display_4.sql?orga_dept_id='||$orga_dept_id AS link;


