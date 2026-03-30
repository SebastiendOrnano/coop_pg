SET project_id = SELECT project_id FROM project_geo_group WHERE geo_group_id=$geo_group_id::INTEGER ;


SET user_role = (
    SELECT user_role FROM users
    INNER JOIN sessions ON users.user_id = sessions.user_id
    WHERE sessions.session_token = sqlpage.cookie('session_token')
); 

SET redirect_link =
CASE WHEN $user_role = 'supervisor' 
THEN '/e_project_geo/geo_select_display_4.sql?geo_group_id='||$geo_group_id::INTEGER
ELSE '/e_project_geo/geo_select_display_3.sql?geo_group_id='||$geo_group_id::INTEGER
END;




UPDATE project_geo 
SET geo_selected = false
RETURNING 
'redirect' AS component, 
$redirect_link AS link;


