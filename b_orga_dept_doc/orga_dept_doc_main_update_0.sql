SET orga_doc_url = sqlpage.persist_uploaded_file('orga_doc_url', 'x_docs', 'doc,docx,odt,md,pdf,jpg,jpeg,png');

UPDATE orga_dept_docs
SET
    orga_doc_title = :orga_doc_title,    
    orga_doc_author = :orga_doc_author,
    orga_doc_url=
    CASE  
    WHEN $orga_doc_url IS NULL OR $orga_doc_url ='' THEN orga_doc_url
    ELSE $orga_doc_url
    END,
    orga_doc_summary = :orga_doc_summary,
    orga_doc_keywords = :orga_doc_keywords,
    orga_doc_date_publication = COALESCE(NULLIF(:orga_doc_date_publication, ''), NULL)::DATE,
    orga_doc_date_period = :orga_doc_date_period,
    orga_doc_format = :orga_doc_format,
    orga_doc_lang =  :orga_doc_lang,
    orga_doc_number_page =  :orga_doc_number_page,
    orga_doc_category = :orga_doc_category,
    orga_doc_status =  :orga_doc_status,
    orga_doc_type =  :orga_doc_type,
    orga_doc_edition = :orga_doc_edition,
    orga_dept_id=COALESCE(NULLIF(:orga_dept_id, ''), NULL)::INTEGER,
    updated_at = CURRENT_TIMESTAMP

WHERE orga_doc_id = $orga_doc_id::INTEGER

RETURNING 
'redirect' AS component, 
'/b_orga_dept_doc/orga_dept_doc_main_display_4.sql?orga_dept_id='||$orga_dept_id  as link;

