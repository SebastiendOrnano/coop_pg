
SET workspace_id = SELECT workspace_id FROM workdocs WHERE workdoc_id = $workdoc_id::INTEGER;

DELETE FROM workdocs
WHERE workdoc_id = $workdoc_id::INTEGER

SELECT 'redirect' AS component,
'/c_workspaces/workdoc_display_4.sql?workspace_id='||$workspace_id AS link;