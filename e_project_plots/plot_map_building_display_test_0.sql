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
  
SET redirect_link = (
    SELECT CASE
        WHEN NOT EXISTS (
            SELECT 1
            FROM project_plots
            WHERE building_id = :building_id::INTEGER
        )
        THEN '/e_project_plots/plot_map_building_alert' || $suffix_role ||'?building_id='||:building_id::INTEGER
        ELSE '/e_project_plots/plot_map_building_display' || $suffix_role ||'?building_id='||:building_id::INTEGER
    END
);

SELECT 
'redirect' AS component, 
$redirect_link AS link;