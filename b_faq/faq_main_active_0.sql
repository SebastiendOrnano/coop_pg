UPDATE faq_questions 
SET 
question_status='active',
updated_at=current_timestamp
WHERE question_id = $question_id::INTEGER

RETURNING 
'redirect' AS component, 
'/b_faq/faq_main_display_4.sql' AS link;