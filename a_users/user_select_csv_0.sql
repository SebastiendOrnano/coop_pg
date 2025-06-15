copy users
(
user_first_name, 
user_last_name, 
user_email
) 
FROM 'user_data_input'
with (header true, delimiter ';', quote '"')

WHERE user_selected=true;