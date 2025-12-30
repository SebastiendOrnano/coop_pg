INSERT INTO place
(
	place_name,
	place_status,
	place_summary,
	place_adress,
	place_postal_code,
	place_town,
	place_country,
	place_contact_phone,
	place_contact_mail,
	place_latitude,
	place_longitude,
	place_type,
	place_accessibility,
	place_capacity_seats,
	place_capacity_standup
	)
VALUES 
(
	:place_name,
	:place_status,
	:place_summary,
	:place_adress,
	COALESCE(NULLIF(:place_postal_code,''), NULL)::INTEGER, 
	:place_town,
	:place_country,
	:place_contact_phone,
	:place_contact_mail,
	COALESCE(NULLIF(:place_latitude,''), NULL)::decimal(9,6), 
	COALESCE(NULLIF(:place_longitude,''), NULL)::decimal(9,6), 
	:place_type,
	:place_accessibility,
	COALESCE(NULLIF(:place_capacity_seats,''), NULL)::INTEGER, 
	COALESCE(NULLIF(:place_capacity_standup,''), NULL)::INTEGER
);

SET place_id = (SELECT MAX(place_id) FROM place WHERE place_name = :place_name);

INSERT INTO place_spaces
(
space_name,
place_id, 
space_rank,
space_type,
space_accessibility,
space_capacity_seats,
space_capacity_standup
)
SELECT
:place_name,
$place_id::INTEGER,
'main',
:place_type,
:place_accessibility,
COALESCE(NULLIF(:place_capacity_seats,''), NULL)::INTEGER, 
COALESCE(NULLIF(:place_capacity_standup,''), NULL)::INTEGER

WHERE :place_name IS NOT NULL

RETURNING 'redirect' AS component,
 '/b_orga_places/orga_place_main_display_4.sql' AS link;


