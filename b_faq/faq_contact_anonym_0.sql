
--SET anonymous 
SET anonymous1=  SELECT(sqlpage.random_string(8));
SET anonymous2=  SELECT(sqlpage.random_string(8));
SET anonymous3=  SELECT(sqlpage.random_string(8));

--UPDATE

UPDATE faq_contacts 
SET  
    contact_first_name=$anonymous1, 
    contact_last_name=$anonymous2, 
    contact_email=$anonymous3||'@noWHERE.com',
    contact_status='archived',
    updated_at = CURRENT_TIMESTAMP
WHERE contact_id=$contact_id::INTEGER

RETURNING
   'redirect' AS component,
   '/b_faq/faq_contact_display_4.sql' as link;

