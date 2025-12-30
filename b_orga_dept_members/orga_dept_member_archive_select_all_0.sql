UPDATE  orga_dept_members 
SET member_selected =true
WHERE member_status = 'archived' AND orga_dept_id=$orga_dept_id::INTEGER

RETURNING 
'redirect' AS component, 
'/b_orga_dept_members/orga_dept_member_archive_display_4.sql?orga_dept_id='||$orga_dept_id    AS link

