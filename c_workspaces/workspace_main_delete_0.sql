DELETE FROM workspace_participants
WHERE workspace_id  = $workspace_id::INTEGER ;

DELETE FROM workdocs
WHERE workspace_id  = $workspace_id::INTEGER ;

DELETE FROM workmeeting_participants
WHERE workspace_id  = $workspace_id::INTEGER;

DELETE FROM workmeetings
WHERE workspace_id  = $workspace_id::INTEGER;

DELETE FROM workspaces
WHERE workspace_id  = $workspace_id ::INTEGER
RETURNING
'redirect' AS component,
'/c_workspaces/workspace_main_display_4.sql' AS link;