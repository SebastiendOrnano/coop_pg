UPDATE prm1 
SET prm1_status = 'active' 
WHERE prm1_selected =true;

UPDATE prm1
SET prm1_selected =false WHERE prm1_selected =true

RETURNING 
'redirect' AS component, 
'/d_prm1/prm1_archive_display_4.sql' AS link;


