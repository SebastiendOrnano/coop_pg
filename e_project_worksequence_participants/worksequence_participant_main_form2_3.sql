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
    'form' AS component,
    '' AS validate;
SELECT 
    'worksequence_id' AS name,
    'hidden' AS type,
    $worksequence_id AS value,
    'id' AS label;
SELECT
    'worksequence_name' AS name,
    TRUE AS readonly,
    'Nom de la séquence de travail' AS label,
     6 AS width,
    (SELECT worksequence_name  FROM project_worksequence WHERE worksequence_id = $worksequence_id::INTEGER ) AS value;

SELECT 
    'title'   AS component,
    'Ajouter une personne morale' AS contents,
    3         AS level;

-- Form for replying to the topic

SELECT 
    'form'      AS component,
    'Ajouter une entreprise' AS validate,
    '/e_project_worksequence_participants/worksequence_participant_main_attach2_0.sql?worksequence_id='||$worksequence_id AS action;

SELECT 
   'prm2_sub_id' AS name,
    'Nom de l''entreprise' AS label,
    'select' AS type,
    8 AS width,
    TRUE AS searchable,
    'Saisissez quelques lettres du nom que vous cherchez ou choississez dans la liste' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.prm2_sub_name, 'value', i.prm2_sub_id)ORDER BY i.prm2_sub_name ASC) AS options
    FROM prm2_sub AS i
    LEFT OUTER JOIN  (SELECT prm2_sub_id FROM project_worksequence_participants) AS t
    ON i.prm2_sub_id = t.prm2_sub_id
    WHERE t.prm2_sub_id IS NULL;
    
 SELECT 
    'worksequence_participant_role'            AS name,
    'Rôle dans le groupement'    AS label,
    'select'                       AS type,
    4                              AS width,
    'Choisir un rôle...'           AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='worksequence_role';