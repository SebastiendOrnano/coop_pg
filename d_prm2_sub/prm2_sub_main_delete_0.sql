SET prm2_id = SELECT prm2_id FROM prm2_sub WHERE prm2_sub_id  = $prm2_sub_id::INTEGER;

DELETE FROM prm2_sub WHERE prm2_sub_id  = $prm2_sub_id::INTEGER
RETURNING
'redirect' AS component,
'/d_prm2_sub/prm2_sub_main_display_4.sql?prm2_id='||$prm2_id AS link;