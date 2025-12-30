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
    'Ajouter une personne physique' AS contents,
    3         AS level;



SELECT 
    'form'      AS component,
    'Ajouter une personne physique' AS validate,
    '/e_project_workpackage_participants/workpackage_participant_main_attach1_0.sql?workpackage_id='||$workpackage_id AS action;

SELECT 
   'prm1_id' AS name,
    'Nom de la personne' AS label,
    'select' AS type,
    8 AS width,
    TRUE AS searchable,
    'Saisissez quelques lettres du nom que vous cherchez ou choississez dans la liste' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label', i.prm1_last_name || '   ' || i.prm1_first_name, 'value', i.prm1_id)ORDER BY I.prm1_last_name ASC, I.prm1_first_name ASC) AS options
    FROM prm1 AS i
    LEFT OUTER JOIN  (SELECT prm1_id FROM project_workpackage_participants) AS t
    ON i.prm1_id = t.prm1_id
    WHERE t.prm1_id IS NULL;

 SELECT 
    'workpackage_participant_role'            AS name,
    'Rôle dans le groupement'    AS label,
    'select'                       AS type,
    4                              AS width,
    'Choisir un rôle...'           AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='project_role';