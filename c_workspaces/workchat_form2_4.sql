SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SELECT
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion Superviseur'         AS title,
    '/a_panels/panel_supervisor_4.sql' AS link;
SELECT 
     '/c_workspaces/workspace_main_display_4.sql'             AS link,
    'Retour espaces de travail'           AS title;
SELECT 
    '/c_workspaces/workspace_hub_display_4.sql?workspace_id='||$workspace_id  AS link,
    'Retour espace du groupe de travail'                                      AS title;
SELECT 
    '/c_workspaces/workspace_participants_display_4.sql?workspace_id='||$workspace_id  AS link,
    'Retour membres du groupe de travail'                                      AS title;


-- Form for adding a new topic and initial message
SELECT 
    'form'  AS component, 
    'Lancer une discussion'  AS title,
    'Valider'                           AS validate,
    'Clear'                              AS reset,
    '/c_workspaces/workchat_create_0.sql?workspace_id='||$workspace_id  AS action;

SELECT 
   'message_recipient_id' AS name,
    'Destinataire' AS label,
    'select' AS type,
    6 AS width,
    TRUE AS searchable,
    TRUE AS required,
    (SELECT workspace_participant_id FROM workspace_participants WHERE workspace_participant_id=$workspace_participant_id::INTEGER ) AS value,
    'Saisissez quelques lettres du nom que vous cherchez ou choississez dans la liste' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label', username || '   (' || user_id|| ')   ' || user_last_name, 'value', user_id)) AS options
    FROM (
    SELECT username, user_first_name, user_last_name, user_id
    FROM users
    ORDER BY user_last_name ASC, user_first_name ASC
    );

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

