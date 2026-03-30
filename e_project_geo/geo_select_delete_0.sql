
DELETE FROM project_geo
WHERE geo_selected = true

RETURNING 
'redirect' AS component, 
'/e_project_geo/geo_select_display_4.sql?geo_group_id='||$geo_group_id  AS link;