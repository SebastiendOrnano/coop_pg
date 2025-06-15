SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SET user_id = (
    SELECT u.user_id  FROM users as u
    LEFT JOIN (SELECT session_id, user_id, session_token FROM sessions) as s
    ON s.user_id = u.user_id
    WHERE s.session_token = sqlpage.cookie('session_token')
);

SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion Superviseur'         AS title,
    '/a_panels/panel_supervisor_4.sql' AS link;
SELECT 
    'Esapces de travail actifs'         AS title,
    '/c_workspaces/workspace_main_display_4.sql' AS link;

SELECT 
    'divider' AS component,
    'Espaces de travail'    AS contents,
    'blue' AS color;

SELECT 
    'table'               AS component, 
    TRUE                  AS sort, 
    'View'                AS markdown,
    TRUE                  AS hover,
--   TRUE                  AS striped_rows,
    TRUE                  AS small,
    TRUE                 AS search;

SELECT
    s.workspace_id               AS Id,
    s.workspace_title            AS Nom,
    s.workspace_summary          AS Description,
    s.workspace_category         AS Categorie,
    s.workspace_status           AS Statut,
    CASE 
    WHEN (SELECT workspace_participant_id FROM workspace_participants AS g WHERE workspace_participant_id=$user_id::INTEGER AND g.workspace_id= s.workspace_id) IS NULL
    THEN '' ELSE 'red' END  AS _sqlpage_color,
    s.workspace_participants_nb  AS NbParticipants,
CASE
WHEN (SELECT  workspace_participant_id FROM workspace_participants AS g WHERE workspace_participant_id=$user_id::INTEGER AND g.workspace_id=s.workspace_id) IS NULL
THEN '[Edit](/c_workspaces/workspace_main_edit_4.sql?workspace_id='||s.workspace_id
||') &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [Delete](/c_workspaces/workspace_main_delete_alert_4.sql?workspace_id='||s.workspace_id||
')'
ELSE '[Edit](/c_workspaces/workspace_main_edit_4.sql?workspace_id='||s.workspace_id||')&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
[Delete](/c_workspaces/workspace_main_delete_alert_4.sql?workspace_id='||s.workspace_id||')' 
END                AS View
FROM workspaces AS s
WHERE s.workspace_status='archived'
ORDER BY workspace_id ASC;



