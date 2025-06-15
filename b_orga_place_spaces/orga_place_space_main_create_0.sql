SET place_name = (SELECT place_name FROM place WHERE place_id=$place_id::INTEGER);

INSERT INTO place_spaces
(
	place_id,
	place_name,
	space_name,
	space_status,
	space_summary,
	space_access,
	space_type,
	space_accessibility,
	space_capacity_seats,
	space_capacity_standup
	)
VALUES 
(
	$place_id::INTEGER,
	$place_name,
	:space_name,
	:space_status,
	:space_summary,
	:space_access,
	:space_type,
	:space_accessibility,
	COALESCE(NULLIF(:space_capacity_seats,''), NULL)::INTEGER, 
	COALESCE(NULLIF(:space_capacity_standup,''), NULL)::INTEGER
)

RETURNING 'redirect' AS component,
 '/b_orga_place_spaces/orga_place_space_main_display_4.sql?place_id='||$place_id AS link;


