UPDATE place SET 
place_name=:place_name,
place_status=:place_status,
place_summary=:place_summary,
place_adress=:place_adress,
place_postal_code=COALESCE(NULLIF(:place_postal_code,''), NULL)::INTEGER, 
place_town=:place_town,
place_country=:place_country,
place_contact_phone=:place_contact_phone,
place_contact_mail=:place_contact_mail,
place_latitude=COALESCE(NULLIF(:place_latitude,''), NULL)::decimal(9,6), 
place_longitude=COALESCE(NULLIF(:place_longitude,''), NULL)::decimal(9,6),
place_type = :place_type,
place_accessibility=:place_accessibility,
place_capacity_seats=COALESCE(NULLIF(:place_capacity_seats,''), NULL)::INTEGER,
place_capacity_standup=COALESCE(NULLIF(:place_capacity_standup,''), NULL)::INTEGER,
updated_at = CURRENT_TIMESTAMP
WHERE place_id = $place_id::INTEGER;

UPDATE  place_spaces SET 
space_name=:place_name,
space_type=:place_type,
space_accessibility=:place_accessibility,
space_capacity_seats=COALESCE(NULLIF(:place_capacity_seats,''), NULL)::INTEGER,
space_capacity_standup=COALESCE(NULLIF(:place_capacity_standup,''), NULL)::INTEGER,
updated_at = CURRENT_TIMESTAMP
WHERE place_id = $place_id::INTEGER AND space_rank='main'

RETURNING 'redirect' AS component,
 '/b_orga_places/orga_place_main_display_4.sql' AS link;


