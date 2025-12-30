UPDATE project
SET
project_status = 'active',
updated_at = CURRENT_TIMESTAMP
WHERE project_id=$project_id::INTEGER

RETURNING 'redirect' AS component,
'/e_project/project_main_display_4.sql' AS link;