UPDATE members 
SET member_selected=false, updated_at = CURRENT_TIMESTAMP


RETURNING 
'redirect' AS component, 
'/b_members/member_archive_display_4.sql' AS link;


