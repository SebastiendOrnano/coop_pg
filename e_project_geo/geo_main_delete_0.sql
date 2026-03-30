set geo_group_id = SELECT geo_group_id FROM project_geo WHERE geo_id=$geo_id::INTEGER;

DELETE FROM project_geo WHERE geo_id  = $geo_id::INTEGER 
RETURNING
'redirect' AS component,
'/e_project_geo/geo_main_display_4.sql?geo_group_id='||$geo_group_id AS link;