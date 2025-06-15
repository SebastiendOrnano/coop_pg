set orga_dept_id = SELECT orga_dept_id FROM orga_dept WHERE orga_dept_id=:orga_dept_id::INTEGER;

SELECT  'redirect' AS component,
'/b_orga_dept_doc/orga_dept_doc_main_display_4.sql?orga_dept_id='||$orga_dept_id AS link;