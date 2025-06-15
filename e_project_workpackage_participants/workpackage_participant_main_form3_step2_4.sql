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
    'text' AS type,
    'Nom du workpackage' AS label,
    12 AS width,
    (SELECT workpackage_name  FROM project_workpackage WHERE workpackage_id = $workpackage_id::INTEGER ) AS value;
SELECT 
    'prm2_sub_id' AS name,
    'text' AS type,
    TRUE AS readonly,
    3 AS width,
    :prm2_sub_id AS value,
    'id' AS label;
SELECT
    'prm2_sub_name' AS name,
    TRUE AS readonly,
    'Nom de la structure employeuse' AS label,
     6 AS width,
    (SELECT prm2_sub_name  FROM prm2_sub WHERE prm2_sub_id = :prm2_sub_id::INTEGER ) AS value;





SELECT 
    'title'   AS component,
    'Ajouter un employé - step 2 : choisir l''employé' AS contents,
    3         AS level;


SELECT 
    'form'      AS component,
    'Ajouter un employé' AS validate,
    '/e_project_workpackage_participants/workpackage_participant_main_attach3_0.sql?workpackage_id='||$workpackage_id AS action;

SELECT 
    'employee_id' AS name,
    'Nom de l''employé' AS label,
    'select' AS type,
    8 AS width,
    TRUE AS searchable,
    'Saisissez quelques lettres du nom que vous cherchez ou choississez dans la liste' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',p.prm1_first_name||'  '||p.prm1_last_name, 'value', e.employee_id)) AS options
    FROM prm2_sub_employees as e
    LEFT JOIN (SELECT prm1_id, prm1_first_name, prm1_last_name FROM prm1) as p
    on p.prm1_id = e.prm1_id
    LEFT OUTER JOIN  (SELECT employee_id FROM project_workpackage_participants) AS t
    ON e.employee_id = t.employee_id
    WHERE t.employee_id IS NULL AND e.prm2_sub_id = :prm2_sub_id::INTEGER;



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
SELECT 
    'prm2_sub_id' AS name,
    'hidden' AS type,
    :prm2_sub_id AS value;;