copy prm1
(
prm1_first_name, 
prm1_last_name, 
prm1_email
) 
FROM 'prm1_data_input'
with (header true, delimiter ';', quote '"')

WHERE prm1_selected=true;