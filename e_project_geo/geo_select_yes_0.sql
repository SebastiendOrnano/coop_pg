SET project_id = SELECT project_id FROM project_geo WHERE geo_id=$geo_id::NTEGER;

SET user_role = (
    SELECT user_role FROM users
    INNER JOIN sessions ON users.user_id = sessions.user_id
    WHERE sessions.session_token = sqlpage.cookie('session_token')
); 

SET redirect_link =
CASE WHEN $user_role = 'supervisor' 
THEN '/e_project_geo/geo_select_display_4.sql?project_id='||$project_id::INTEGER
ELSE '/e_project_geo/geo_select_display_3.sql?project_id='||$project_id::INTEGER
END;



UPDATE project_geo 
SET geo_selected = 
(CASE 
    WHEN geo_selected =true THEN false
    ELSE true END)
WHERE geo_id=$geo_id::NTEGER

RETURNING 
'redirect' AS component, 
$redirect_link AS link;


