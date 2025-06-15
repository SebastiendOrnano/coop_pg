UPDATE choices_items
SET
choice_label = :choice_label,
choice_value = :choice_value,
choice_category_id = 
    CASE 
    WHEN :choice_category_id::INTEGER  IS NULL
    THEN choice_category_id::INTEGER 
    ELSE :choice_category_id::INTEGER  END,
choice_status = 
    CASE 
    WHEN :choice_status IS NULL
    THEN choice_status
    ELSE :choice_status END,

updated_at = CURRENT_TIMESTAMP
WHERE choice_id=$choice_id::INTEGER 

RETURNING 'redirect' AS component,
'/a_choices/choice_main_display_5.sql' AS link;