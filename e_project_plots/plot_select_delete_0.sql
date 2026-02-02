SET project_id = SELECT project_id FROM project_plots WHERE plot_id = $plot_id::INTEGER;

DELETE FROM project_plots
WHERE plot_selected = true

RETURNING 
'redirect' AS component, 
'/e_project_plots/plot_select_display_4.sql?plot_id='||$plot_id||'&project_id='||$project_id AS link;