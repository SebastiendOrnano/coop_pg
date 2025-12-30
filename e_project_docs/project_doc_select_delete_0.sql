INSERT INTO files_to_erase (file_url) 
SELECT project_doc_url FROM project_docs
WHERE project_doc_selected = true;

DELETE FROM project_docs
WHERE project_doc_selected = true

RETURNING 
'redirect' AS component, 
'/e_project_docs/project_doc_select_display_4.sql?project_id='||$project_id AS link;