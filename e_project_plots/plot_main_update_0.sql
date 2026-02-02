SET project_id=SELECT project_id FROM project_plots WHERE plot_id=$plot_id::INTEGER;

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
  
SET redirect_link = '/e_project_plots/plot_main_display'||$suffix_role||'?project_id='||$project_id;

UPDATE project_plots 
SET 
plot_title=:plot_title,
plot_status=:plot_status,
building_id=COALESCE(NULLIF(:building_id,''), NULL)::INTEGER,
plot_description=:plot_description,
plot_code_postal=COALESCE(NULLIF(:plot_code_postal ,''), NULL)::VARCHAR(5),
plot_code_insee=COALESCE(NULLIF(:plot_code_insee ,''), NULL)::VARCHAR(5),
plot_code_land_registry=COALESCE(NULLIF(:plot_code_land_registry ,''), NULL)::TEXT,
updated_at = CURRENT_TIMESTAMP
WHERE plot_id = $plot_id::INTEGER

RETURNING 'redirect' AS component,
$redirect_link AS link;


