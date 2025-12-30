DELETE FROM orga_dept_members
WHERE member_selected = true AND orga_dept_id=$orga_dept_id::INTEGER
RETURNING
   'redirect' AS component,
   '/b_orga_dept_members/orga_dept_member_select_display_4.sql?orga_dept_id='||$orga_dept_id AS link;