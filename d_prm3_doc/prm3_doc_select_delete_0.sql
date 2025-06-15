INSERT INTO files_to_erase (file_url)
SELECT prm3_doc_url FROM prm3_docs WHERE  prm3_doc_selected = true;

DELETE FROM prm3_docs
WHERE prm3_doc_selected = true AND prm3_id=$prm3_id::INTEGER;

RETURNING 
'redirect' AS component, 
'/d_prm3_doc/prm3_doc_select_no_0.sql?prm3_id='||$prm3_id AS link;