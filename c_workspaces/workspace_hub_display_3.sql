SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_3.sql') AS properties;

SET workspace_title = SELECT workspace_title FROM workspaces WHERE workspace_id=$workspace_id::INTEGER;

SET user_id = (
    SELECT u.user_id  FROM users as u
    LEFT JOIN (SELECT session_id, user_id, session_token FROM sessions) as s
    ON s.user_id = u.user_id
    WHERE s.session_token = sqlpage.cookie('session_token')
);

SET user_role = (
    SELECT user_role FROM users
    INNER JOIN sessions ON users.user_id = sessions.user_id
    WHERE sessions.session_token = sqlpage.cookie('session_token')
);

SET workspace_coordinator = 
CASE
WHEN (SELECT workspace_coordinator_id FROM workspaces WHERE workspace_id=$workspace_id::INTEGER)= $user_id::INTEGER 
THEN 'coordinator'
ELSE ''
END;


SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion éditeur'         AS title,
    '/a_panels/panel_editor_3.sql' AS link;
SELECT 
    'Espaces de travail'            AS title,
    '/c_workspaces/workspace_main_display_3.sql' AS link;


SELECT 
    'datagrid'              AS component,
    'panel_hub_workspace_display' AS id,
    'ESPACE DE TRAVAIL DU GROUPE : '||$workspace_title AS title;

SELECT 
    '/c_workspaces/workmeeting_form_3.sql?workspace_id='||$workspace_id    AS link,
    'Création d''une réunion'                       AS description,
    'calendar-time'                                      AS icon,
    'yellow'                                        AS color;

SELECT 
    '/c_workspaces/workdoc_form_3.sql?workspace_id='||$workspace_id    AS link,
    'Ajouter un document'                       AS description,
    'book'                                      AS icon,
    'green'                                     AS color;

SELECT 
    '/c_workspaces/workdoc_display_3.sql?workspace_id='||$workspace_id        AS link,
    'Liste des documents'                              AS description,
    'library'                                          AS icon,
    'red'                                              AS color;
SELECT 
    '/c_workspaces/workdoc_cloud_form_3.sql?workspace_id='||$workspace_id    AS link,
    'Ajouter un document en ligne'                       AS description,
    'cloud-share'                                      AS icon,
    'green'                                     AS color;

SELECT 
    '/c_workspaces/workdoc_cloud_display_3.sql?workspace_id='||$workspace_id        AS link,
    'Liste des documents en ligne'                              AS description,
    'cloud-down'                                          AS icon,
    'red'                                              AS color;

SELECT 
    '/c_workspaces/workspace_participants_display_3.sql?workspace_id='||$workspace_id        AS link,
    'membres du groupe de travail'                    AS description,
    'users-group'                                     AS icon,
    'blue'                                            AS color;

SELECT 
    '/c_workspaces/workforum_topic_display_3.sql?workspace_id='||$workspace_id        AS link,
    'Discussions collectives en cours (forum)'          AS description,
    'arrows-random'                                     AS icon,
    'red'                                               AS color;

SELECT 
    '/c_workspaces/workchat_display_3.sql?workspace_id='||$workspace_id        AS link,
    'Discussions perso en cours (chat)'                                        AS description,
    'messages'                                                                 AS icon,
    'green'                                                                    AS color;

SELECT 
    'divider'              AS component,
    'Liste des événements à venir' AS contents,
    'left'                 AS position,
    'black'                AS color;


SELECT 'table' AS component, 
    'Liste des événements à venir'   AS title, 
    'Alert'          AS markdown,
    'View'           AS markdown,
    TRUE             AS sort, 
    TRUE             AS small,
    TRUE             AS search;

SELECT
    CASE WHEN (SELECT e.workmeeting_alert IS NULL OR e.workmeeting_alert = 'alert_end') THEN '' ELSE '![warning](/x_icons/warning32px.png)' END  AS  Alert,
    CASE WHEN (SELECT e.workmeeting_alert IS NULL OR e.workmeeting_alert = 'alert_end') THEN '' ELSE e.workmeeting_alert  END                    AS alert_type,
    CASE WHEN (SELECT e.workmeeting_alert IS NULL OR e.workmeeting_alert = 'alert_end') THEN '' ELSE 'red' END                                   AS _sqlpage_color,
    e.workmeeting_title             AS Nom,
    e.workmeeting_status           AS statut,
    CASE WHEN e.workmeeting_visio='visio' THEN 'visio' ELSE 'présentiel'  END  AS type,
    e.workmeeting_date             AS Date,
    e.workmeeting_hour_start       AS heure,
    '[View - Register](/c_workspaces/workmeeting_participants_display_3.sql?workmeeting_id='||e.workmeeting_id||'&workspace_id='||$workspace_id||')
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Edit](/c_workspaces/workmeeting_edit_3.sql?workmeeting_id='||e.workmeeting_id||'&workspace_id='||$workspace_id||')'
    AS View
FROM workmeetings AS e
LEFT JOIN place_spaces AS s 
ON s.space_id = e.space_id
WHERE e.workmeeting_title IS NOT NULL AND e.workmeeting_status !='archived' AND e.workmeeting_date > CURRENT_DATE AND workspace_id=$workspace_id::INTEGER
ORDER BY e.workmeeting_date DESC;

