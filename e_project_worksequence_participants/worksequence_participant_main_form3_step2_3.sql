SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_3.sql') AS properties;

SET workpackage_id = SELECT workpackage_id FROM project_worksequence WHERE worksequence_id=$worksequence_id::INTEGER;
SET project_id = SELECT project_id FROM project_workpackage WHERE workpackage_id=$workpackage_id::INTEGER;


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
    'Gestion des participants à la séquence'            as title,
    '/e_project_worksequence_participants/worksequence_participant_main_display_4.sql?worksequence_id='||$worksequence_id  as link;

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
    'title'   as component,
    'Ajouter un employé d''une entreprise - étape 2 : choisir l''employé' as contents,
    3         as level;


SELECT 
    'form'      AS component,
    'Ajouter un employé' as validate,
    '/e_project_worksequence_participants/worksequence_participant_main_attach3_0.sql?worksequence_id='||$worksequence_id AS action;

SELECT 
    'employee_id' as name,
    'Nom de l''employé' as label,
    'select' as type,
    8 AS width,
    TRUE as searchable,
    'Saisissez quelques lettres du nom que vous cherchez ou choississez dans la liste' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',p.prm1_first_name||'  '||p.prm1_last_name, 'value', e.employee_id)) AS options
    FROM prm2_sub_employees as e
    LEFT JOIN (SELECT prm1_id, prm1_first_name, prm1_last_name FROM prm1) as p
    on p.prm1_id = e.prm1_id
    LEFT OUTER JOIN  (SELECT employee_id FROM project_worksequence_participants) AS t
    ON e.employee_id = t.employee_id
    WHERE t.employee_id IS NULL AND e.prm2_sub_id = :prm2_sub_id::INTEGER;



 SELECT 
    'worksequence_participant_role'            as name,
    'Rôle dans le groupement'    as label,
    'select'                       as type,
    4                              AS width,
    'Choisir un rôle...'           as empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='worksequence_role';

SELECT 
    'prm2_sub_id' AS name,
    'hidden' AS type,
    :prm2_sub_id AS value;;