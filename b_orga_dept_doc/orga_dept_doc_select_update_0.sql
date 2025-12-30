UPDATE orga_dept_docs
SET     
    orga_doc_author = CASE 
    WHEN :orga_doc_author IS NULL OR :orga_doc_author = '' 
    THEN orga_doc_author
    ELSE :orga_doc_author END,

    orga_doc_keywords = CASE 
    WHEN :orga_doc_keywords IS NULL OR :orga_doc_keywords = '' 
    THEN orga_doc_keywords
    ELSE :orga_doc_keywords END,
   
    orga_doc_date_publication = CASE 
    WHEN :orga_doc_date_publication IS  NULL OR :orga_doc_date_publication = '' 
    THEN orga_doc_date_publication 
    ELSE :orga_doc_date_publication::DATE END,
    
    orga_doc_date_period = CASE 
    WHEN :orga_doc_date_period IS NULL OR :orga_doc_date_period = '' 
    THEN orga_doc_date_period 
    ELSE :orga_doc_date_period END,
    
    orga_doc_format = CASE 
    WHEN :orga_doc_format IS NULL OR :orga_doc_format = '' 
    THEN orga_doc_format 
    ELSE :orga_doc_format END,
    
    orga_doc_lang = CASE 
    WHEN :orga_doc_lang IS NULL OR :orga_doc_lang = '' 
    THEN orga_doc_lang 
    ELSE :orga_doc_lang END,
    
    orga_doc_number_page = CASE 
    WHEN :orga_doc_number_page IS NULL OR :orga_doc_number_page = '' 
    THEN orga_doc_number_page 
    ELSE :orga_doc_number_page END,
    
    orga_doc_category = CASE 
    WHEN :orga_doc_category IS NULL OR :orga_doc_category = '' 
    THEN orga_doc_category 
    ELSE :orga_doc_category END,
    
    orga_doc_status = CASE 
    WHEN :orga_doc_status IS NULL OR :orga_doc_status = '' 
    THEN orga_doc_status 
    ELSE  :orga_doc_status END,
    
    orga_doc_type = CASE 
    WHEN :orga_doc_type IS  NULL OR :orga_doc_type = '' 
    THEN orga_doc_type 
    ELSE :orga_doc_type END,
    
    orga_doc_edition = CASE 
    WHEN :orga_doc_edition IS  NULL OR :orga_doc_edition = '' 
    THEN orga_doc_edition 
    ELSE :orga_doc_edition END,

    orga_dept_id=
    CASE
    WHEN :orga_dept_id IS NULL OR :orga_dept_id = '' THEN orga_dept_id 
    ELSE :orga_dept_id::INTEGER   END,  
    
    updated_at = CURRENT_TIMESTAMP

WHERE 
    orga_doc_selected = true;

UPDATE orga_dept_docs
SET 
orga_doc_selected=false, 
updated_at = CURRENT_TIMESTAMP

RETURNING 'redirect' AS component, 
'/b_orga_dept_doc/orga_dept_doc_select_no_0.sql?orga_dept_id='||$orga_dept_id AS link;