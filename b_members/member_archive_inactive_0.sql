UPDATE members 
SET member_status = 'inactive' 
WHERE member_selected =true;

UPDATE members
SET member_selected =false WHERE member_selected =true

RETURNING 
'redirect' AS component, 
'/b_members/member_archive_display_4.sql' AS link;


