DELETE FROM prm2 WHERE prm2_id  = $prm2_id::INTEGER

RETURNING
'redirect' AS component,
'/d_prm2/prm2_main_display_4.sql' AS link;