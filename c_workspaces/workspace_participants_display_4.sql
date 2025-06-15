SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SET user_id = (
    SELECT u.user_id  FROM users as u
    LEFT JOIN (SELECT session_id, user_id, session_token FROM sessions) as s
    ON s.user_id = u.user_id
    WHERE s.session_token = sqlpage.cookie('session_token')
);

SET user_role =
CASE
WHEN (SELECT workspace_participant_role FROM workspace_participants WHERE  workspace_participant_id=$user_id::INTEGER AND workspace_id=$workspace_id::INTEGER) = 'coordinator'
THEN 'coordinator' 
ELSE '' END ;

SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion Superviseur'         AS title,
    '/a_panels/panel_supervisor_4.sql' AS link;
SELECT 
    'Retour à l''espace de travail'            AS title,
     '/c_workspaces/workspace_hub_display_4.sql?workspace_id='||$workspace_id  AS link;

SELECT 
    'table'               AS component, 
    TRUE                  AS sort, 
    'View'                AS markdown, 
    'Role'           AS  markdown;

SELECT
    CASE 
    WHEN workspace_participant_role = 'coordinator' THEN 'coordinator'
    WHEN (workspace_participant_role  != 'coordinator' OR workspace_participant_role IS NULL) AND $user_role = 'coordinator'
    THEN  '[Set AS coordo](/c_workspaces/workspace_paticipants_update_0.sql?workspace_participant_id='||workspace_participant_id||'&workspace_id='||workspace_id||')'
    ELSE 'Participant'
    END                                                                        AS Role,
    workspace_participant_id                                                   AS Id,
    (SELECT user_first_name FROM users as u
    LEFT JOIN (select user_id, workspace_participant_id, workspace_id FROM workspace_participants) as p
    ON u.user_id = p.user_id     
    (SELECT user_first_name FROM users as u  WHERE u.user_id = p.user_id)      AS Prenom,
    (SELECT user_last_name FROM users as u  WHERE u.user_id = p.user_id)      AS Nom,
    CASE 
    WHEN workspace_participant_id = $user_id::INTEGER THEN ''
    ELSE    '[Chat](/c_workspaces/workchat_form1_4.sql?workspace_participant_id='||workspace_participant_id||'&workspace_id='||workspace_id||')&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Delete](/c_workspaces/workspace_participant_delete_alert1_4.sql?workspace_participant_id='||workspace_participant_id||'&workspace_id='||workspace_id||')' END AS View
FROM workspace_participants as p
WHERE workspace_id = $workspace_id::INTEGER
ORDER BY created_at ASC;