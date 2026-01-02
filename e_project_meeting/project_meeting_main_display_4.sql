SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SET user_id = (
    SELECT users.user_id  FROM users
    INNER JOIN sessions ON users.user_id = sessions.user_id
    WHERE sessions.session_token = sqlpage.cookie('session_token')
); 

SET user_role = (
    SELECT user_role FROM users
    INNER JOIN sessions ON users.user_id = sessions.user_id
    WHERE sessions.session_token = sqlpage.cookie('session_token')
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
    'Retour à la liste des projets'            AS title,
    '/e_project/project_main_display_4.sql'     AS link;   
 SELECT 
    'Retour au hub du projet'            AS title,
    '/e_project/project_hub_display_4.sql?project_id='||$project_id     AS link;

SELECT 
    'datagrid'              AS component,
    'panel_project_meeting_display' AS id,
    'Gestion des réunions du projet :  '|| $project_name AS title;
SELECT 
    '/e_project_meeting/project_meeting_main_form_4.sql?project_id='||$project_id          AS link,
    'Création d''une nouvelle réunion'          AS description,
    'calendar-time'                                    AS icon,
    'yellow'                                   AS color;
SELECT 
    '/e_project_meeting/project_meeting_archive_display_4.sql?project_id='||$project_id          AS link,
    'Réunions archivées ou terminées'          AS description,
    'archive'                                    AS icon,
    'yellow'                                   AS color;

SELECT 'table' AS component, 
    'Liste des événements à venir'   AS title, 
    'Alert'          AS markdown,
    JSON('{"name":"View","tooltip":"Voir le détail de la réunion","link":"/e_project_meeting/project_meeting_main_view_3.sql?project_meeting_id={id}","icon":"user-circle"}') as custom_actions,
    JSON('{"name":"Participantsl","Liste des participants":"Voir le profil","link":"/e_project_meeting/project_meeting_participants_display_3.sql?project_meeting_id={id}","icon":"users"}') as custom_actions,
    TRUE             AS sort, 
    TRUE             AS small,
    TRUE             AS search;

SELECT
    CASE WHEN (SELECT e.project_meeting_alert IS NULL OR e.project_meeting_alert = 'alert_end') THEN '' ELSE '![warning](/x_icons/warning32px.png)' END  AS  Alert,
   
    e.project_meeting_title             AS Nom,
    e.project_meeting_id             AS _sqlpage_id,
    e.project_meeting_status           AS statut,
    CASE 
    WHEN e.project_meeting_visio='visio' THEN 'visio'
    ELSE 'présentiel'  END            AS type,
    e.project_meeting_date             AS Date,
    e.project_meeting_hour_start       AS heure,
    p.project_meeting_place_name       AS Lieu,
   SELECT user_id
    FROM project_meeting_participants
    WHERE project_meeting_participant_role = 'coordinator'
    AND project_meeting_id = e.project_meeting_id::integer
    LIMIT 1
    ) = $user_id::integer
    OR $user_role = 'supervisor'
    THEN JSON('{"name":"Edit","tooltip":"Voir le détail de la réunion","link":"/e_project_meeting/project_meeting_main_edit_3.sql?project_meeting_id='||e.project_meeting_id||'","icon":"edit"}')
    ELSE  JSON('{"name":"Edit"}')
    END   AS _sqlpage_actions
FROM project_meeting AS e
LEFT JOIN (SELECT project_meeting_place_name, project_meeting_place_id FROM project_meeting_places ) AS p 
ON p.project_meeting_place_id = e.project_meeting_place_id
WHERE e.project_meeting_title IS NOT NULL AND e.project_meeting_status ='active' AND e.project_meeting_date > CURRENT_DATE AND project_id=$project_id::INTEGER
ORDER BY e.project_meeting_date DESC;
