DELETE FROM faq_questions 
WHERE question_id = $question_id::INTEGER

RETURNING 
'redirect' AS component, 
'/b_faq/faq_main_display_4.sql' AS link;