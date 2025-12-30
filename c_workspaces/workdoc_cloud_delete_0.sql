SET workspace_id = SELECT workspace_id FROM workdocs_cloud WHERE  workdoc_cloud_id = $workdoc_cloud_id::INTEGER;

DELETE FROM workdocs_cloud
WHERE workdoc_cloud_id = $workdoc_cloud_id::INTEGER

SELECT 'redirect' AS component,
'/c_workspaces/workdoc_cloud_display_4.sql?workspace_id='||$workspace_id AS link;