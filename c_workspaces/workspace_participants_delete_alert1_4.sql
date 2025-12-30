SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SET workspace_id = SELECT workspace_id FROM workspace_participants WHERE workspace_participant_id=$workspace_participant_id::INTEGER;


SELECT 
    'alert'                    AS component,
    'Suppression d''un membre du groupe' AS title,
    'analyze'                  AS icon,
    'teal'                     AS color,
    'Cette suppression n''entrainera pas la suppression de l''utilisateur mais seulement celle de sa présence dans la liste des membres !' AS description;

SELECT 
    '/c_workspaces/workspace_participants_delete_0.sql?workspace_participant_id='||$workspace_participant_id  AS link,
    'Retirer le membre du groupe'          AS title,
    'red'                                  AS color;

SELECT 
    '/c_workspaces/workspace_participants_display_4.sql?workspace_id='||$workspace_id    AS link,
    'Retour à la liste' AS title,
    'green'    AS color;

