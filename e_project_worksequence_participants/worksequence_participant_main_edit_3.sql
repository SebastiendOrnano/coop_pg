SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_3.sql') AS properties;

SET worksequence_id = SELECT worksequence_id FROM project_worksequence_participants WHERE worksequence_participant_id=$worksequence_participant_id::INTEGER;

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
    'title'     as component,
    'Groupement'    as contents,
    3           as level;

SELECT 
    'form' as component,
    '' as validate;
SELECT 
    'worksequence_id' as name,
    'hidden' as type,
    $worksequence_id as value,
    'id' as label;
SELECT
    'worksequence_name' as name,
    TRUE as readonly,
    'Nom de la séquence de travail' as label,
     6 as width,
    (SELECT worksequence_name  FROM project_worksequence WHERE worksequence_id = $worksequence_id::INTEGER ) as value;

SELECT 
    'title'     as component,
    'Participant'    as contents,
    3           as level;

SELECT 
    'form'      AS component,
    'Actualiser un participant' as validate,
    '/e_project_worksequence_participants/worksequence_participant_main_update_0.sql?worksequence_participant_id='||$worksequence_participant_id AS action;

SELECT 
    'worksequence_participant_role'            as name,
    'Rôle dans l''équipe de travail'   as label,
    'select'                       as type,
    4                              AS width,
    (SELECT worksequence_participant_role FROM project_worksequence_participants WHERE worksequence_participant_id=$worksequence_participant_id::INTEGER ) as value,
    'Choisir un rôle...'           as empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='worksequence_role';

SELECT 
    'worksequence_participant_status'      as name,
    'Statut actif-archive'          as label,
    'select'                       as type,
    4                              AS width,
    (SELECT worksequence_participant_status FROM project_worksequence_participants WHERE worksequence_participant_id=$worksequence_participant_id::INTEGER ) as value,
    'Choisir un status..'           as empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='status';