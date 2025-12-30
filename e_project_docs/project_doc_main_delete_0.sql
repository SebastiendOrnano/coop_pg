SET project_id = SELECT project_id FROM project_docs WHERE project_doc_id = $project_doc_id::INTEGER;

DELETE FROM project_docs
WHERE project_doc_id = $project_doc_id::INTEGER
RETURNING
   'redirect' AS component,
   '/e_project_docs/project_doc_main_display_4.sql?project_id='||$project_id AS link;