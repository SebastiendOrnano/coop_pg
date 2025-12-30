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


SELECT 
    'form'                                  AS component,
    'Ajouter un invité (personne physique)' AS validate,
    'Clear'                                  AS reset,
    '/e_project_meeting/project_meeting_participant_attach2_step1_0.sql?project_meeting_id='||$project_meeting_id AS action;

SELECT 
   'prm2_sub_id' AS name,
    'Choisir l''entreprise employeur' AS label,
    'select' AS type,
    8 AS width,
    TRUE AS searchable,
    'Saisissez quelques lettres du nom que vous cherchez ou choississez dans la liste' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',prm2_sub_name, 'value', prm2_sub_id)) AS options
    FROM (
    SELECT prm2_sub_name, prm2_sub_id
    FROM prm2_sub 
    ORDER BY prm2_sub_name ASC
    );
