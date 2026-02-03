set project_id = SELECT project_id FROM project_geo WHERE geo_id=$geo_id::NTEGER;

DELETE FROM project_geo WHERE geo_id  = $geo_id::INTEGER 
RETURNING
'redirect' AS component,
'/e_project_geo/geo_main_display_4.sql?project_id='||project_id AS link;