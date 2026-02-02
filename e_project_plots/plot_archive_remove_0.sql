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
plot_status='arctive',
updated_at = CURRENT_TIMESTAMP
WHERE plot_id = $plot_id::INTEGER

RETURNING 'redirect' AS component,
$redirect_link AS link;


