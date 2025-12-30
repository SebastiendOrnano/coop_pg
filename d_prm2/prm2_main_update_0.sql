SET prm2_logo_url = sqlpage.persist_uploaded_file('prm2_logo_url', 'x_logos', 'jpg,jpeg,png');

SET user_role = (
    SELECT user_role FROM users
    INNER JOIN sessions ON users.user_id = sessions.user_id
    WHERE sessions.session_token = sqlpage.cookie('session_token')
); 

SET redirect_link =
CASE WHEN $user_role = 'supervisor' 
THEN  '/d_prm2/prm2_main_display_4.sql'
ELSE  '/d_prm2/prm2_main_display_3.sql'
END;

UPDATE prm2
SET
prm2_status = 
    CASE 
    WHEN :prm2_status IS NULL OR :prm2_status = '' 
    THEN prm2_status
    ELSE :prm2_status END,
prm2_name=:prm2_name,
prm2_acronym=:prm2_acronym,
prm2_punchline=:prm2_punchline,
prm2_summary=:prm2_summary,
prm2_logo_url=
CASE  
WHEN $prm2_logo_url IS NULL OR $prm2_logo_url ='' THEN prm2_logo_url
ELSE $prm2_logo_url
END,
prm2_adress=:prm2_adress,
prm2_postal_code=COALESCE(NULLIF(:prm2_postal_code,''), NULL)::INTEGER, 
prm2_town=:prm2_town,
prm2_country=:prm2_country,
prm2_contact_phone=:prm2_contact_phone,
prm2_contact_mail=:prm2_contact_mail,
prm2_latitude=COALESCE(NULLIF(:prm2_latitude,''), NULL)::REAL, 
prm2_longitude=COALESCE(NULLIF(:prm2_longitude, ''), NULL)::REAL,
prm2_legal_status = 
    CASE 
    WHEN :prm2_legal_status IS NULL OR :prm2_legal_status = '' 
    THEN prm2_legal_status
    ELSE :prm2_legal_status END,
prm2_no_siret=COALESCE(NULLIF(:prm2_no_siret, ''), NULL)::INTEGER,
prm2_no_siren=COALESCE(NULLIF(:prm2_no_siren, ''), NULL)::INTEGER,
prm2_no_tva_intracom=COALESCE(NULLIF(:prm2_no_tva_intracom, ''), NULL)::INTEGER,
prm2_no_rna=:prm2_no_rna,
prm2_code_naf_ape=:prm2_code_naf_ape,
prm2_date_creation=COALESCE(NULLIF(:prm2_date_creation, ''), NULL)::DATE,
prm2_number_employees=COALESCE(NULLIF(:prm2_number_employees, ''), NULL)::INTEGER,
updated_at = CURRENT_TIMESTAMP
WHERE prm2_id=$prm2_id::INTEGER

RETURNING 'redirect' AS component,
$redirect_link AS link;