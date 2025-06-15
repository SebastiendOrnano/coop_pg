SET prm3_doc_url = sqlpage.persist_uploaded_file('prm3_doc_url','x_docs','doc,docx,odt,md,pdf,jpg,jpeg,png');
SET prm3_id = (SELECT prm3_id  FROM prm3_docs WHERE prm3_doc_id = $prm3_doc_id::INTEGER );

SET user_role = (
    SELECT user_role FROM users
    INNER JOIN sessions ON users.user_id = sessions.user_id
    WHERE sessions.session_token = sqlpage.cookie('session_token')
); 

SET redirect_link =
CASE WHEN $user_role = 'supervisor' 
THEN    '/d_prm3_doc/prm3_doc_main_display_4.sql?prm3_id='||$prm3_id
ELSE    '/d_prm3_doc/prm3_doc_main_display_3.sql?prm3_id='||$prm3_id
END;


UPDATE prm3_docs
SET
    prm3_doc_title = :prm3_doc_title,    
    prm3_doc_url= 
    CASE  
    WHEN $prm3_doc_url IS NULL OR $prm3_doc_url ='' THEN prm3_doc_url
    ELSE $prm3_doc_url
    END,
    prm3_doc_summary = :prm3_doc_summary,
    prm3_doc_keywords = :prm3_doc_keywords,
    prm3_doc_date_publication = COALESCE(NULLIF(:prm3_doc_date_publication, ''), NULL)::DATE,
    prm3_doc_format = :prm3_doc_format,
    prm3_doc_category = :prm3_doc_category,
    prm3_doc_status =  :prm3_doc_status,
    prm3_doc_type =  :prm3_doc_type,
    updated_at = CURRENT_TIMESTAMP

WHERE prm3_doc_id = $prm3_doc_id::INTEGER

RETURNING 
'redirect' AS component, 
$redirect_link as link;

