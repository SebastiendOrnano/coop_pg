SET project_id = SELECT project_id FROM project_geo_group WHERE geo_group_id=$geo_group_id::INTEGER ;

DELETE FROM project_geo_group
WHERE geo_group_id = $geo_group_id::INTEGER

RETURNING 
'redirect' AS component, 
'/e_project_geo/geo_group_display_4.sql?project_id='||$project_id AS link;