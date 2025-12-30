SET place_id = (SELECT place_id FROM place_spaces WHERE space_id=$space_id::INTEGER);

UPDATE place_spaces 
SET 
space_name=:space_name,
space_rank=:space_rank,
space_status=:space_status,
space_summary=:space_summary,
space_access=:space_access,
space_type = :space_type,
space_accessibility=:space_accessibility,
space_capacity_seats=COALESCE(NULLIF(:space_capacity_seats,''), NULL)::INTEGER, 
space_capacity_standup=COALESCE(NULLIF(:space_capacity_standup,''), NULL)::INTEGER,
updated_at = CURRENT_TIMESTAMP
WHERE space_id = $space_id::INTEGER

RETURNING 'redirect' AS component,
 '/b_orga_place_spaces/orga_place_space_main_display_4.sql?place_id='||$place_id AS link;


