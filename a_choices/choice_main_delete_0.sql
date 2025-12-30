DELETE FROM choices_items
WHERE choice_id  = $choice_id::INTEGER 

RETURNING
'redirect' AS component,
'/a_choices/choice_main_display_5.sql' AS link;