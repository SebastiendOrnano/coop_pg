SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SET user_id = (
    SELECT users.user_id  FROM users
    INNER JOIN sessions ON users.user_id = sessions.user_id
    WHERE sessions.session_token = sqlpage.cookie('session_token')
); 

SET project_id=(SELECT project_id FROM project_meeting WHERE project_meeting_id=$project_meeting_id::INTEGER);

SET coordinator = 
CASE
WHEN (SELECT user_id FROM project_meeting_participants WHERE project_meeting_participant_role='coordinator' AND project_meeting_id=$project_meeting_id::INTEGER)= $user_id::INTEGER
THEN 'coordinator'
ELSE ''
END;

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
    'Retour à la liste des réunions'            AS title,
    '/e_project_meeting/project_meeting_main_display_4.sql?project_id='||$project_id     AS link;


SET participant_name = SELECT
    CASE
    WHEN p.project_meeting_participant_type='orga_member'
    THEN u.user_first_name||'--'||u.user_last_name
    WHEN p.project_meeting_participant_type='person' OR p.project_meeting_participant_type= 'employee'
    THEN m.prm1_first_name||'--'||m.prm1_last_name
    END                                           AS value
FROM project_meeting_participants AS p
LEFT JOIN (SELECT user_id, user_first_name, user_last_name, user_email FROM users ) AS u
ON p.user_id = u.user_id
LEFT JOIN (SELECT prm1_id, prm1_first_name, prm1_last_name, prm1_email FROM prm1 ) AS m
ON p.prm1_id = m.prm1_id
WHERE p.project_meeting_participant_id=$project_meeting_participant_id::INTEGER;


SELECT 
    'form'                                  AS component,
    'Changer le rôle d''un participant'      AS validate,
    'Clear'                                  AS reset,
    '/e_project_meeting/project_meeting_participant_update_0.sql?project_meeting_participant_id='||$project_meeting_participant_id AS action;

SELECT 
   'prm1_name' AS name,
    'Nom du participant' AS label,
    'text' AS type,
    8 AS width,
    TRUE AS readonly,
   $participant_name AS value;

SELECT 
   'project_meeting_participant_role' AS name,
    'Rôle du participant' AS label,
    'select' AS type,
    4 AS width,
    'Choisir un role dans la liste...'    AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='meeting_participant_role';
