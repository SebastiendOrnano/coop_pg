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
    'form'                                  AS component,
    'Ajouter un invité (personne physique)' AS validate,
    'Clear'                                  AS reset,
    '/e_project_meeting/project_meeting_participant_attach1_0.sql?project_meeting_id='||$project_meeting_id AS action;

SELECT 
   'prm1_id' AS name,
    'Nom de la personne invitée' AS label,
    'select' AS type,
    8 AS width,
    TRUE AS required,
    TRUE AS searchable,
    'Saisissez quelques lettres du nom que vous cherchez ou choississez dans la liste' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label', prm1_last_name || '   ' || prm1_first_name, 'value', prm1_id)) AS options
    FROM (
    SELECT prm1_last_name, prm1_first_name, prm1_id
    FROM prm1 
    ORDER BY prm1_last_name ASC, prm1_first_name ASC
    );

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
