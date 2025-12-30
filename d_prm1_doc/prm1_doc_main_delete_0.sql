SET prm1_id = (SELECT prm1_id  FROM prm1_doc WHERE prm1_doc_id = $prm1_doc_id::INTEGER );


DELETE FROM prm1_doc
WHERE prm1_doc_id = $prm1_doc_id::INTEGER
RETURNING
   'redirect' AS component,
   '/d_prm1_doc/prm1_doc_main_display_4.sql?prm1_id='||$prm1_id AS link;