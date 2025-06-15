SET prm3_doc_url= (SELECT prm3_doc_url  FROM prm3_docs WHERE prm3_doc_id = $prm3_doc_id::INTEGER );
SET prm3_id = (SELECT prm3_id  FROM prm3_docs WHERE prm3_doc_id = $prm3_doc_id::INTEGER );

DELETE FROM prm3_docs
WHERE prm3_doc_id = $prm3_doc_id::INTEGER
RETURNING
   'redirect' AS component,
   '/d_prm3_doc/prm3_doc_main_display_4.sql?prm3_id='||$prm3_id as link;