DELETE FROM workspace_participants
WHERE workspace_participant_id = $workspace_participant_id AND workspace_id=$workspace_id

SELECT 'redirect' AS component,
'/c_workspaces/workspace_participants_display_4.sql?workspace_id='||$workspace_id AS link;