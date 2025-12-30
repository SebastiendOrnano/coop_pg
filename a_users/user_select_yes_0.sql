UPDATE users 
SET user_selected = 
CASE 
WHEN user_selected IS true THEN false
ELSE true END
WHERE user_id = $user_id::INTEGER 

RETURNING 
'redirect' AS component, 
'/a_users/user_select_display_5.sql' AS link;


