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
    'Projets'            AS title,
    '/e_project/project_main_display_3.sql'   AS link;   
 SELECT 
    'Hub projet'            AS title,
    '/e_project/project_hub_display_3.sql?project_id='||$project_id     AS link;   
SELECT 
    'Hub lot de travaux'            AS title,
    '/e_project_workpackage/workpackage_hub_display_3.sql?workpackage_id='||$workpackage_id    AS link;

SELECT 
    'Gestion des participants'            AS title,
    '/e_project_workpackage_participants/workpackage_participant_main_display_3.sql?workpackage_id='||$workpackage_id  AS link;


SELECT 
    'title'     AS component,
    'Groupement'    AS contents,
    3           AS level;

SELECT 
    'form' AS component,
    '' AS validate;
SELECT 
    'workpackage_id' AS name,
    'hidden' AS type,
    $workpackage_id AS value,
    'id' AS label;
SELECT
    'workpackage_name' AS name,
    TRUE AS readonly,
    'Nom du groupe' AS label,
     6 AS width,
    (SELECT workpackage_name  FROM project_workpackage WHERE workpackage_id = $workpackage_id::INTEGER ) AS value;

SELECT 
    'title'     AS component,
    'Participant'    AS contents,
    3           AS level;

SELECT 
    'form'      AS component,
    'Actualiser un participant' AS validate,
    '/e_project_workpackage_participants/workpackage_participant_main_update_0.sql?workpackage_participant_id='||$workpackage_participant_id AS action;

SELECT 
    'workpackage_participant_role'            AS name,
    'Rôle dans le groupement'    AS label,
    'select'                       AS type,
    4                              AS width,
    (SELECT workpackage_participant_role FROM project_workpackage_participants WHERE workpackage_participant_id=$workpackage_participant_id::INTEGER ) AS value,
    'Choisir un rôle...'           AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='worksequence_role';

SELECT 
    'workpackage_participant_status'      AS name,
    'Statut actif-archive'          AS label,
    'select'                       AS type,
    4                              AS width,
    (SELECT workpackage_participant_status FROM project_workpackage_participants WHERE workpackage_participant_id=$workpackage_participant_id::INTEGER ) AS value,
    'Choisir un status..'           AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='status';