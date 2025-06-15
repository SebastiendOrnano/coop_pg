SET user_role = (
    SELECT user_role FROM users
    INNER JOIN sessions ON users.user_id = sessions.user_id
    WHERE sessions.session_token = sqlpage.cookie('session_token')
); 

SET redirect_link =
CASE WHEN $user_role = 'supervisor' 
THEN    '/d_prm1_doc/prm1_doc_main_display_4.sql?prm1_id='||$prm1_id
ELSE    '/d_prm1_doc/prm1_doc_main_display_3.sql?prm1_id='||$prm1_id
END;

UPDATE prm1_doc
SET     
    prm1_doc_author = CASE 
    WHEN :prm1_doc_author IS NULL OR :prm1_doc_author = '' 
    THEN prm1_doc_author
    ELSE :prm1_doc_author END,

    prm1_doc_keywords = CASE 
    WHEN :prm1_doc_keywords IS NULL OR :prm1_doc_keywords = '' 
    THEN prm1_doc_keywords
    ELSE :prm1_doc_keywords END,
   
    prm1_doc_date_publication = CASE 
    WHEN :prm1_doc_date_publication IS  NULL OR :prm1_doc_date_publication = '' 
    THEN prm1_doc_date_publication 
    ELSE :prm1_doc_date_publication::DATE END,
    
    prm1_doc_date_period = CASE 
    WHEN :prm1_doc_date_period IS NULL OR :prm1_doc_date_period = '' 
    THEN prm1_doc_date_period 
    ELSE :prm1_doc_date_period::INTEGER END,
    
    prm1_doc_format = CASE 
    WHEN :prm1_doc_format IS NULL OR :prm1_doc_format = '' 
    THEN prm1_doc_format 
    ELSE :prm1_doc_format END,
    
    prm1_doc_lang = CASE 
    WHEN :prm1_doc_lang IS NULL OR :prm1_doc_lang = '' 
    THEN prm1_doc_lang 
    ELSE :prm1_doc_lang END,
    
    prm1_doc_category = CASE 
    WHEN :prm1_doc_category IS NULL OR :prm1_doc_category = '' 
    THEN prm1_doc_category 
    ELSE :prm1_doc_category END,
    
    prm1_doc_status = CASE 
    WHEN :prm1_doc_status IS NULL OR :prm1_doc_status = '' 
    THEN prm1_doc_status 
    ELSE  :prm1_doc_status END,
    
    prm1_doc_type = CASE 
    WHEN :prm1_doc_type IS  NULL OR :prm1_doc_type = '' 
    THEN prm1_doc_type 
    ELSE :prm1_doc_type END,
   
    updated_at = CURRENT_TIMESTAMP

WHERE 
    prm1_doc_selected = true;

UPDATE prm1_doc
SET prm1_doc_selected=false, updated_at = CURRENT_TIMESTAMP

RETURNING 'redirect' AS component, 
'/d_prm1_doc/prm1_doc_select_no_0.sql?prm1_id='||$prm1_id AS link;