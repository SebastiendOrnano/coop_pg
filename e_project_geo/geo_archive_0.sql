SET geo_group_id = SELECT geo_group_id FROM project_geo WHERE geo_id=$geo_id::integer
SET project_id = SELECT project_id FROM project_geo_group WHERE geo_group_id=$geo_group_id::INTEGER ;

SET user_role = (
    SELECT user_role FROM users
    INNER JOIN sessions ON users.user_id = sessions.user_id
    WHERE sessions.session_token = sqlpage.cookie('session_token')
); 

SET suffix_role = 
(
	    SELECT
        CASE
            WHEN $user_role = 'supervisor' THEN '_4.sql'
            WHEN $user_role = 'editor' THEN '_3.sql'
        END
);
  
SET redirect_link = '/e_project_geo/geo_main_display'||$suffix_role||'?geo_group_id='||$geo_group_id;

UPDATE project_geo 
SET 
geo_status='archived',
updated_at = CURRENT_TIMESTAMP
WHERE geo_id=$geo_id::INTEGER 

RETURNING 'redirect' AS component,
$redirect_link AS link;


