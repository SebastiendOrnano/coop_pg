
--SET anonymous 
SET anonymous1=  SELECT(sqlpage.random_string(8));
SET anonymous2=  SELECT(sqlpage.random_string(8));
SET anonymous3=  SELECT(sqlpage.random_string(8));

--UPDATE

UPDATE users 
SET  
    user_first_name=$anonymous1, 
    user_last_name=$anonymous2, 
    user_phone='000000',
    user_email=$anonymous3||'@noWHERE.com',
    user_status='archived'
    updated_at = CURRENT_TIMESTAMP
WHERE user_selected=true

RETURNING
   'redirect' AS component,
   '/b_users/user_main_display_4.sql' AS link;

