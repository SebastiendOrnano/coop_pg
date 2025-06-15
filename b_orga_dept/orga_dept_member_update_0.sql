
SET orga_dept_id = :orga_dept_id::INTEGER;

UPDATE members
SET 
orga_dept_id=:orga_dept_id::INTEGER,
updated_at = CURRENT_TIMESTAMP
WHERE member_id = :member_id::INTEGER

SELECT 'redirect' AS component,
'/b_orga_dept/orga_dept_member_display_4.sql?orga_dept_id='||$orga_dept_id AS link;

