DELETE FROM orga_dept_partners
WHERE orga_partner_id = $orga_partner_id::INTEGER
RETURNING
   'redirect' AS component,
   '/b_orga_partners/orga_partner_display_4.sql?orga_dept_id='||$orga_dept_id AS link;