UPDATE members 
SET member_selected = CASE 
WHEN member_selected =true THEN false
ELSE true END
WHERE member_id = $member_id

RETURNING 
'redirect' AS component, 
'/b_members/member_archive_display_4.sql' AS link;


