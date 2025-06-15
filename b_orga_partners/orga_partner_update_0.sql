
UPDATE  orga_partners
SET 
orga_partner_name=:orga_partner_name, 
orga_partner_acronym=:orga_partner_acronym,
orga_partner_punchline=:orga_partner_punchline,
orga_partner_scope=:orga_partner_scope,
orga_partner_type=:orga_partner_type,
orga_partner_category=:orga_partner_category,
orga_partner_status=:orga_partner_status,
orga_partner_date_since= NULLIF(:orga_partner_date_since, '')::DATE,
orga_partner_logo_url= 
CASE  
WHEN sqlpage.persist_uploaded_file('orga_partner_logo_url', 'x_logos', 'jpg,jpeg,png') IS NULL OR sqlpage.persist_uploaded_file('orga_partner_logo_url', 'x_logos', 'jpg,jpeg,png') ='' THEN orga_partner_logo_url
ELSE sqlpage.persist_uploaded_file('orga_partner_logo_url', 'x_logos', 'jpg,jpeg,png')
END,
orga_partner_logo_title=:orga_partner_logo_title,
orga_partner_link=:orga_partner_link,
orga_partner_summary=:orga_partner_summary, 
orga_dept_id=:orga_dept_id::INTEGER
    
WHERE orga_partner_id=$orga_partner_id::INTEGER
RETURNING  'redirect' AS component,
'/b_orga_partners/orga_partner_display_4.sql' AS link;


