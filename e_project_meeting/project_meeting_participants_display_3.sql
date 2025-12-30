SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_3.sql') AS properties;

SET user_id = (
    SELECT u.user_id  FROM users as u
    INNER JOIN (select user_id, session_token from sessions) as s  
    ON u.user_id = s.user_id
    WHERE s.session_token = sqlpage.cookie('session_token')
); 

SET project_id=(SELECT project_id FROM project_meeting WHERE project_meeting_id=$project_meeting_id::INTEGER);

SET coordinator = 
CASE
WHEN (SELECT user_id FROM project_meeting_participants WHERE project_meeting_participant_role='coordinator' AND project_meeting_id=$project_meeting_id::INTEGER)= $user_id::INTEGER
THEN 'coordinator'
ELSE ''
END;

SET project_meeting_title = SELECT project_meeting_title FROM project_meeting WHERE project_meeting_id=$project_meeting_id::INTEGER;

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
    'Retour à la liste des réunions'            AS title,
    '/e_project_meeting/project_meeting_main_display_3.sql?project_id='||$project_id     AS link;


SELECT 
    'datagrid'              AS component,
    'panel_project_meeting_place_display' AS id,
    'Liste des partcipants de la la réunion : '||$project_meeting_title AS title;

SELECT 
    '/e_project_meeting/project_meeting_main_join_0.sql?project_meeting_id='||$project_meeting_id       AS link,
    'S''inscrire'                                     AS description,
    'copy-plus'                                       AS icon,
    'green'                                           AS color;

SELECT 
    '/e_project_meeting/project_meeting_main_quit_0.sql?project_meeting_id='||$project_meeting_id       AS link,
    'Se désinscrire'                             AS description,
    'copy-plus'                                  AS icon,
    'red'                                        AS color;

SELECT 
    '/e_project_meeting/project_meeting_participant_form1_3.sql?project_meeting_id='||$project_meeting_id       AS link,
   'Inscrire une personne physique (PRM1)'       AS description,
    'copy-plus'                                  AS icon,
    'green'                                      AS color;

SELECT 
    '/e_project_meeting/project_meeting_participant_form2_step1_3.sql?project_meeting_id='||$project_meeting_id       AS link,
   'Inscrire un employé '    AS description,
    'copy-plus'                                                 AS icon,
    'red'                                                       AS color;


-- Display list of organizations
SELECT 'table' AS component, 
    'Liste des participants'   AS title, 
    'View'           AS markdown;

SELECT
    p.project_meeting_participant_id                    AS Id,
    p.project_meeting_participant_role                    AS Role,
    p.project_meeting_participant_type                    AS Type,
    CASE 
    WHEN p.project_meeting_participant_type='orga_member'
    THEN u.user_first_name
    WHEN p.project_meeting_participant_type='person'
    THEN m.prm1_first_name
    WHEN p.project_meeting_participant_type='employee'
    THEN m.prm1_first_name
    END                                            AS Prénom,
    CASE 
    WHEN p.project_meeting_participant_type='orga_member'
    THEN u.user_last_name
    WHEN p.project_meeting_participant_type='person'
    THEN m.prm1_last_name
    WHEN p.project_meeting_participant_type='employee'
    THEN m.prm1_last_name
    END                                    AS Nom,
    CASE 
    WHEN p.project_meeting_participant_type='employee'
    THEN s.prm2_sub_name
    ELSE ''
    END                                    AS Compagny,
    CASE 
    WHEN p.project_meeting_participant_type='orga_member'
    THEN u.user_email
    WHEN p.project_meeting_participant_type='person'
    THEN m.prm1_email
    WHEN p.project_meeting_participant_type='employee'
    THEN m.prm1_email
    END                                    AS Mail,
    '[remove](/e_project_meeting/project_meeting_participant_remove_0.sql?project_meeting_participant_id='||p.project_meeting_participant_id||')&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[change role](/e_project_meeting/project_meeting_participant_edit_3.sql?project_meeting_participant_id='||p.project_meeting_participant_id||')'  AS view
FROM project_meeting_participants AS p
LEFT JOIN (SELECT user_id, user_first_name, user_last_name, user_email FROM users ) AS u
ON p.user_id = u.user_id
LEFT JOIN (SELECT prm1_id, prm1_first_name, prm1_last_name, prm1_email FROM prm1 ) AS m
ON p.prm1_id = m.prm1_id
LEFT JOIN (SELECT employee_id, prm2_sub_id, prm1_id FROM prm2_sub_employees) AS e
on p.employee_id = e.employee_id
LEFT JOIN (SELECT prm2_sub_id, prm2_sub_name FROM prm2_sub) AS s
on p.prm2_sub_id = s.prm2_sub_id
WHERE p.project_meeting_id=$project_meeting_id::INTEGER
ORDER BY created_at ASC;
