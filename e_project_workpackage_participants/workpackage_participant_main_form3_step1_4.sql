SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

set project_id = SELECT project_id FROM project_workpackage WHERE workpackage_id=$workpackage_id::INTEGER;

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
    'liste des lots de travaux'    AS title,
    '/e_project_workpackage/workpackage_hub_display_4.sql?project_id='||$project_id AS link;
SELECT 
    'Participants au lot de travaux'    AS title,
    '/e_project_workpackage_participants/workpackage_participant_main_display_4.sql?workpackage_id='||$workpackage_id AS link;

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
    'Nom du workpackage' AS label,
     6 AS width,
    (SELECT workpackage_name  FROM project_workpackage WHERE workpackage_id = $workpackage_id::INTEGER ) AS value;

SELECT 
    'title'   AS component,
    'Ajouter un employé - step 1 : choisir l''entreprise' AS contents,
    3         AS level;

SELECT 
    'form'      AS component,
    'Choisir l''entreprise' AS validate,
    '/e_project_workpackage_participants/workpackage_participant_main_form3_step2_4.sql?workpackage_id='||$workpackage_id AS action;

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

