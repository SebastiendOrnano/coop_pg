
--SET anonymous 
SET anonymous1=  SELECT(sqlpage.random_string(8));
SET anonymous2=  SELECT(sqlpage.random_string(8));
SET anonymous3=  SELECT(sqlpage.random_string(8));

SET contact_email = SELECT contact_email FROM faq_contacts AS c
    LEFT JOIN (SELECT contact_id, question_id FROM faq_questions)  AS q 
    ON c.contact_id = q.contact_id
    WHERE question_id = $question_id::INTEGER;

UPDATE faq_contacts 
SET  
    contact_first_name=$anonymous1, 
    contact_last_name=$anonymous2, 
    contact_email=$anonymous3||'@noWHERE.com',
    contact_status='archived',
    updated_at = CURRENT_TIMESTAMP
WHERE contact_email=$contact_email

RETURNING
   'redirect' AS component,
   '/b_faq/faq_main_display_4.sql' as link;

