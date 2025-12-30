UPDATE users 
SET 
user_selected = false

RETURNING 
'redirect' AS component, 
'/a_users/user_select_display_5.sql' AS link;


