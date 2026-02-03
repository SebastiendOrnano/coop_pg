

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
  
SET redirect_link = '/e_project_geo/geo_select_display'||$suffix_role||'?project_id='||$project_id;

UPDATE project_geo 
SET 
geo_status=:geo_status,
building_id=COALESCE(NULLIF(:building_id,''), NULL)::INTEGER,
geo_code_postal=COALESCE(NULLIF(:geo_code_postal ,''), NULL)::VARCHAR(5),
geo_code_insee=COALESCE(NULLIF(:geo_code_insee ,''), NULL)::VARCHAR(5),
updated_at = CURRENT_TIMESTAMP
WHERE geo_selected = TRUE;

UPDATE project_geo 
SET geo_selected = false
RETURNING 
'redirect' AS component, 
$redirect_link AS link;