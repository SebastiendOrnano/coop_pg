SET orga_dept_id = SELECT orga_dept_id FROM orga_dept_partners WHERE orga_partner_id=$orga_partner_id::INTEGER;

UPDATE orga_dept_partners 
SET orga_partner_status = 'active' 
WHERE orga_partner_id=$orga_partner_id::INTEGER

RETURNING  'redirect' AS component,
'/b_orga_dept_partners/orga_partner_display_4.sql?orga_dept_id='||$orga_dept_id AS link


