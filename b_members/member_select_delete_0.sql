DELETE FROM members
WHERE member_selected = true
RETURNING
   'redirect' AS component,
   '/b_members/member_select_display_4.sql' AS link;