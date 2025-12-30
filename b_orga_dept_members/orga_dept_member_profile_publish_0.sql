SET orga_dept_id = SELECT orga_dept_id FROM orga_dept_members WHERE member_id=$member_id::INTEGER;


UPDATE  orga_dept_members 
SET 
member_publish=true, 
updated_at = CURRENT_TIMESTAMP
WHERE member_id = $member_id::INTEGER

RETURNING 
'redirect' AS component, 
'/b_orga_dept_members/orga_dept_member_main_display_4.sql?orga_dept_id='||$orga_dept_id AS link;


