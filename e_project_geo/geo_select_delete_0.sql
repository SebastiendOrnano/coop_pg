SET project_id = SELECT project_id FROM project_geo WHERE geo_id=$geo_id::NTEGER;

DELETE FROM project_geo
WHERE geo_selected = true

RETURNING 
'redirect' AS component, 
'/e_project_geo/geo_select_display_4.sql?geo_id='||$geo_id||'&project_id='||$project_id AS link;