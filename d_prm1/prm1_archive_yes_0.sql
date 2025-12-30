UPDATE prm1 
SET prm1_selected = 
CASE 
WHEN prm1_selected =true THEN false
ELSE true END
WHERE prm1_id = $prm1_id::INTEGER

RETURNING 
'redirect' AS component, 
'/d_prm1/prm1_archive_display_4.sql' AS link;


