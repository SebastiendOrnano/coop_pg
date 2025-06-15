SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_3.sql') AS properties;

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
    'Gestion éditeur'         AS title,
    '/a_panels/panel_editor_3.sql' AS link;
 SELECT 
    'Retour à la liste des projets'            AS title,
    '/e_project/project_main_display_3.sql'     AS link;   
 SELECT 
    'Retour au hub du projet'            AS title,
    '/e_project/project_hub_display_3.sql?project_id='||$project_id     AS link;

SELECT 
    'datagrid'              AS component,
    'panel_project_meeting_display' AS id,
    'Gestion des réunions du projet :  '|| $project_name AS title;
SELECT 
    '/e_project_meeting/project_meeting_main_form_3.sql?project_id='||$project_id          AS link,
    'Création d''une nouvelle réunion'          AS description,
    'calendar-time'                                    AS icon,
    'yellow'                                   AS color;


SELECT 'table' AS component, 
    'Liste des événements à venir'   AS title, 
    'Alert'          AS markdown,
    'View'           AS markdown,
    TRUE             AS sort, 
    TRUE             AS small,
    TRUE             AS search;

SELECT
    CASE WHEN (SELECT e.project_meeting_alert IS NULL OR e.project_meeting_alert = 'alert_end') THEN '' ELSE '![warning](/x_icons/warning32px.png)' END  AS  Alert,
   
    e.project_meeting_title             AS Nom,
    e.project_meeting_status           AS statut,
    CASE 
    WHEN e.project_meeting_visio='visio' THEN 'visio'
    ELSE 'présentiel'  END            AS type,
    e.project_meeting_date             AS Date,
    e.project_meeting_hour_start       AS heure,
    p.project_meeting_place_name       AS Lieu,
   '[View](/e_project_meeting/project_meeting_main_view_3.sql?project_meeting_id='||e.project_meeting_id||')&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
   [Participants](/e_project_meeting/project_meeting_participants_display_3.sql?project_meeting_id='||e.project_meeting_id||')&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;' 
    ||CASE
    WHEN (SELECT user_id FROM project_meeting_participants WHERE project_meeting_participant_role='coordinator' AND project_meeting_id=e.project_meeting_id::INTEGER)  = ($user_id::INTEGER) OR $user_role='supervisor'
    THEN'[Edit](/e_project_meeting/project_meeting_main_edit_3.sql?project_meeting_id='||e.project_meeting_id||')' 
    ELSE ''
    END   AS View


FROM project_meeting AS e
LEFT JOIN (SELECT project_meeting_place_name, project_meeting_place_id FROM project_meeting_places ) AS p 
ON p.project_meeting_place_id = e.project_meeting_place_id
WHERE e.project_meeting_title IS NOT NULL AND e.project_meeting_status ='active' AND e.project_meeting_date > CURRENT_DATE AND project_id=$project_id::INTEGER
ORDER BY e.project_meeting_date DESC;