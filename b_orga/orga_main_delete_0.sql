DELETE FROM members
WHERE orga_id  = $orga_id::INTEGER ;

DELETE FROM orga_docs
WHERE orga_id  = $orga_id::INTEGER ;

DELETE FROM orga_dept
WHERE orga_id  = $orga_id::INTEGER ;

DELETE FROM orga
WHERE orga_id  = $orga_id::INTEGER 

RETURNING
'redirect' AS component,
'/b_orga/orga_main_display_4.sql' AS link;