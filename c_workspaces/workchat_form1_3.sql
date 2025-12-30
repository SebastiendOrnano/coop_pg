SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_3.sql') AS properties;

SELECT
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion éditeur'         AS title,
    '/a_panels/panel_editor_3.sql' AS link;
SELECT 
     '/c_workspaces/workspace_main_display_3.sql'             AS link,
    'Espaces de travail'           AS title;
SELECT 
    '/c_workspaces/workspace_hub_display_3.sql?workspace_id='||$workspace_id  AS link,
    'Espace du groupe de travail'                                      AS title;
SELECT 
    '/c_workspaces/workspace_participants_display_3.sql?workspace_id='||$workspace_id  AS link,
    'Membres du groupe de travail'                                      AS title;


-- Form for adding a new topic and initial message
SELECT 
    'form'  AS component, 
    'Lancer une discussion'  AS title,
    'Valider'                           AS validate,
    'Clear'                              AS reset,
    '/c_workspaces/workchat_create_0.sql?workspace_id='||$workspace_id  AS action;

SELECT 
   'message_name' AS name,
    'Destinataire' AS label,
    'text' AS type,
    6 AS width,
    true  AS readonly,
    (SELECT CONCAT(user_first_name, '  ', user_last_name) FROM users as u
    LEFT JOIN (select user_id, workspace_participant_id, workspace_id FROM workspace_participants) as p 
    ON u.user_id = p.user_id
    WHERE p.workspace_participant_id = $workspace_participant_id::INTEGER )    as value;

SELECT 
   'message_recipient_id' AS name,
    'Destinataire' AS label,
    'hidden' AS type,
    6 AS width,
    true  AS readonly,
    (SELECT u.user_id FROM users as u
    LEFT JOIN (select user_id, workspace_participant_id, workspace_id FROM workspace_participants) as p 
    ON u.user_id = p.user_id
    WHERE p.workspace_participant_id = $workspace_participant_id::INTEGER )    as value;



SELECT 
    'Sujet'             AS label,
    'topic_name'        AS name,
    'text'              AS type, 
    'Enter topic title' AS placeholder, 
    TRUE AS required;

SELECT 
    'message_content'  AS name, 
    'Votre message'  AS label,
    'textarea'       AS type, 
    /* TRUE AS required, */
    'Your message' AS placeholder,
    'Vous pouvez rédiger en markdown !' AS description;

