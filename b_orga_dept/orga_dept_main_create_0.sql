

INSERT INTO orga_dept 
(   
	orga_dept_name,
    orga_id,
	orga_dept_acronym,
	orga_dept_logo_url,
	orga_dept_punchline,
	orga_dept_summary,
	orga_dept_adress,
	orga_dept_postal_code,
	orga_dept_town,
	orga_dept_country,
	orga_dept_contact_phone,
	orga_dept_contact_mail,
	orga_dept_latitude,
	orga_dept_longitude,
	orga_dept_rank,
	orga_dept_status,
	orga_dept_legal_status,
	orga_dept_no_rna,
	orga_dept_no_siren,
	orga_dept_no_siret,
	orga_dept_no_tva_intracom,
	orga_dept_code_naf_ape,
	orga_dept_date_creation,
	orga_dept_number_employees
)
VALUES 
(
	:orga_dept_name,
	$orga_id::INTEGER,
	:orga_dept_acronym,
	:orga_dept_logo_url,
	:orga_dept_punchline,
	:orga_dept_summary,
	:orga_dept_adress,
	COALESCE(NULLIF(:orga_dept_postal_code,''),NULL)::INTEGER,
	:orga_dept_dept_town,
	:orga_dept_country,
	:orga_dept_contact_phone,
	:orga_dept_contact_mail,
	COALESCE(NULLIF(:orga_dept_latitude,''),NULL)::DECIMAL(9,6),
	COALESCE(NULLIF(:orga_dept_longitude,''),NULL)::DECIMAL(9,6),
	'dept',
	'active',
	:orga_dept_legal_status,
	:orga_dept_no_rna,
	COALESCE(NULLIF(:orga_dept_no_siren,''),NULL)::INTEGER,
	COALESCE(NULLIF(:orga_dept_no_siret,''),NULL)::INTEGER,
	COALESCE(NULLIF(:orga_dept_no_tva_intracom,''),NULL)::INTEGER,
	:orga_dept_code_naf_ape,
	COALESCE(NULLIF(:orga_dept_date_creation,''),NULL)::DATE,
	COALESCE(NULLIF(:orga_dept_number_employees,''),NULL)::INTEGER
	)

RETURNING 'redirect' AS component,
 '/b_orga_dept/orga_dept_main_display_4.sql?orga_id='||$orga_id AS link;


