SET project_id = SELECT project_id FROM project_plots WHERE plot_id = $plot_id::INTEGER;

SET user_role = (
    SELECT user_role FROM users
    INNER JOIN sessions ON users.user_id = sessions.user_id
    WHERE sessions.session_token = sqlpage.cookie('session_token')
); 

SET redirect_link =
CASE WHEN $user_role = 'supervisor' 
THEN '/e_project_plots/plot_select_display_4.sql?project_id='||$project_id::INTEGER
ELSE '/e_project_plots/plot_select_display_3.sql?project_id='||$project_id::INTEGER
END;



UPDATE project_plots 
SET plot_selected = 
(CASE 
    WHEN plot_selected =true THEN false
    ELSE true END)
WHERE plot_id = $plot_id::INTEGER

RETURNING 
'redirect' AS component, 
$redirect_link AS link;


