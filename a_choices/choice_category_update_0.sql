UPDATE choices_categories
SET
choice_category_name = :choice_category_name,
choice_category_summary = :choice_category_summary,
choice_category_status = 
    CASE 
    WHEN :choice_category_status IS NULL
    THEN choice_category_status
    ELSE :choice_category_status END,
updated_at = CURRENT_TIMESTAMP
WHERE choice_category_id=$choice_category_id::INTEGER 

RETURNING 'redirect' AS component,
'/a_choices/choice_category_display_5.sql' AS link;