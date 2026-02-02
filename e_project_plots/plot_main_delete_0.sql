set project_id = SELECT project_id FROM project_plots WHERE plot_id = $plot_id::INTEGER;

DELETE FROM project_plots WHERE plot_id  = $plot_id::INTEGER 
RETURNING
'redirect' AS component,
'/e_project_plots/plot_main_display_4.sql?project_id='||project_id AS link;