SET orga_dept_id= SELECT orga_dept_id FROM members WHERE member_id=$member_id::INTEGER;


SET orga_dept_id=(SELECT orga_dept_id FROM members WHERE member_id=$member_id::INTEGER);

UPDATE members
SET 
orga_id='', 
orga_dept_id='',
updated_at = CURRENT_TIMESTAMP
WHERE member_id = $member_id

SELECT 'redirect' AS component,
'/b_orga_dept/orga_dept_member_main_display_4.sql?orga_dept_id='||$orga_dept_id AS link;