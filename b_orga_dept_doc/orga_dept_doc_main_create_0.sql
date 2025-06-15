INSERT INTO orga_docs 
( 
orga_doc_title, 
orga_doc_author, 
orga_doc_url,
orga_doc_summary, 
orga_doc_keywords,
orga_dept_id,
orga_doc_date_publication, 
orga_doc_date_period, 
orga_doc_lang,
orga_doc_format,
orga_doc_number_page,
orga_doc_category,
orga_doc_type,
orga_doc_edition,
orga_doc_status
)

VALUES
(
:orga_doc_title, 
:orga_doc_author, 
sqlpage.persist_uploaded_file('orga_doc_url', 'x_docs', 'doc,docx,odt,md,pdf,jpg,jpeg,png'),
:orga_doc_summary, 
:orga_doc_keywords,
:orga_dept_id::INTEGER, 
COALESCE(NULLIF(:orga_doc_date_publication, ''), NULL)::DATE,
:orga_doc_date_period,
:orga_doc_lang,
:orga_doc_format,
:orga_doc_number_page,
:orga_doc_category,
:orga_doc_type,
:orga_doc_edition,
:orga_doc_status);

set orga_dept_id = SELECT orga_dept_id FROM orga_dept WHERE orga_dept_id=:orga_dept_id::INTEGER;

SELECT  'redirect' AS component,
'/b_orga_dept_doc/orga_dept_doc_main_display_4.sql?orga_dept_id='||$orga_dept_id AS link;

