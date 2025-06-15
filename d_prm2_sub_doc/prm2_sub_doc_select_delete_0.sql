SET prm2_id = SELECT prm2_id FROM prm2_sub WHERE prm2_sub_id = $prm2_sub_id::INTEGER;

INSERT INTO files_to_erase (file_url) 
SELECT prm2_sub_doc_url FROM prm2_sub_docs
WHERE prm2_sub_doc_selected = true;

DELETE FROM prm2_sub_docs
WHERE prm2_sub_doc_selected = true

RETURNING 
'redirect' AS component, 
'/d_prm2_sub_doc/prm2_sub_doc_select_display_4.sql?prm2_sub_id='||$prm2_sub_id||'&prm2_id='||$prm2_id AS link;