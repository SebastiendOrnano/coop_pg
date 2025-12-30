-- First execute the DELETE query with RETURNING
DELETE FROM orga_dept_docs
WHERE orga_dept_id = $orga_dept_id::INTEGER AND orga_doc_selected = true
RETURNING 
  'redirect' AS component, 
  '/b_orga_dept_doc/orga_dept_doc_select_no_0.sql?orga_dept_id=' || $orga_dept_id AS link;

-- Then execute the SELECT query only if no rows were deleted by checking the existence condition
SELECT 
  'redirect' AS component, 
  '/b_orga_dept_doc/orga_dept_doc_select_no_0.sql?orga_dept_id=' || $orga_dept_id AS link
WHERE NOT EXISTS (
  SELECT 1 FROM orga_dept_docs WHERE orga_dept_id = $orga_dept_id::INTEGER AND orga_doc_selected = true
);

