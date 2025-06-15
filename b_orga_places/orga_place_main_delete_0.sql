DELETE FROM place_spaces_pictures
WHERE place_id  = $place_id::INTEGER;

DELETE FROM place_spaces
WHERE place_id  = $place_id::INTEGER;

DELETE FROM place WHERE place_id  = $place_id::INTEGER
RETURNING
'redirect' AS component,
'/b_orga_places/orga_place_main_display_4.sql' AS link;