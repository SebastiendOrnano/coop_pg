SET orga_id = (SELECT orga_id FROM orga_dept WHERE orga_dept_id=$orga_dept_id::INTEGER);

UPDATE orga_dept
SET
orga_dept_status = 
    CASE 
    WHEN :orga_dept_dept_status IS NULL OR :orga_dept_dept_status = '' 
    THEN orga_dept_status
    ELSE :orga_dept_dept_status END,
orga_dept_name=:orga_dept_name,
orga_dept_acronym=:orga_dept_acronym,
orga_dept_punchline=:orga_dept_punchline,
orga_dept_summary=:orga_dept_summary,
orga_dept_logo_url=
CASE  
WHEN sqlpage.persist_uploaded_file('orga_dept_logo_url', 'x_logos', 'jpg,jpeg,png') ='' 
THEN orga_dept_logo_url
ELSE sqlpage.persist_uploaded_file('orga_dept_logo_url', 'x_logos', 'jpg,jpeg,png')
END,
orga_dept_adress=:orga_dept_adress,
orga_dept_postal_code=COALESCE(NULLIF(:orga_dept_postal_code,''),NULL)::INTEGER, 
orga_dept_town=:orga_dept_town,
orga_dept_country=:orga_dept_country,
orga_dept_contact_phone=:orga_dept_contact_phone,
orga_dept_contact_mail=:orga_dept_contact_mail,
orga_dept_latitude=COALESCE(NULLIF(:orga_dept_latitude,''),NULL)::DECIMAL(9,6),
orga_dept_longitude=COALESCE(NULLIF(:orga_dept_longitude,''),NULL)::DECIMAL(9,6),
orga_dept_legal_status = 
    CASE 
    WHEN :orga_dept_dept_legal_status IS NULL OR :orga_dept_dept_legal_status = '' 
    THEN orga_dept_legal_status
    ELSE :orga_dept_dept_legal_status END,
orga_dept_no_siret=COALESCE(NULLIF(:orga_dept_no_siret,''),NULL)::INTEGER,
orga_dept_no_siren=COALESCE(NULLIF(:orga_dept_no_siren,''),NULL)::INTEGER,
orga_dept_no_rna=:orga_dept_no_rna,
orga_dept_code_naf_ape=:orga_dept_code_naf_ape,
orga_dept_no_tva_intracom=COALESCE(NULLIF(:orga_dept_no_tva_intracom,''),NULL)::INTEGER,
orga_dept_date_creation=COALESCE(NULLIF(:orga_dept_date_creation,''),NULL)::DATE,
orga_dept_number_employees=COALESCE(NULLIF(:orga_dept_number_employees,''),NULL)::INTEGER,
updated_at = CURRENT_TIMESTAMP
WHERE orga_dept_id = $orga_dept_id::INTEGER

RETURNING 'redirect' AS component,
 '/b_orga_dept/orga_dept_main_display_4.sql?orga_id='||$orga_id AS link;


