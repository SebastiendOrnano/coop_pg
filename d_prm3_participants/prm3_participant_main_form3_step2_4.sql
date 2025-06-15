SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SELECT 
    'breadcrumb' as component;
SELECT 
    'Home' as title,
    '/'    as link;
SELECT 
    'Gestion Superviseur'         as title,
    '/a_panels/panel_supervisor_4.sql' as link;
SELECT 
    'Gestion des groupements'            as title,
     '/d_prm3/prm3_main_display_4.sql' as link;
SELECT 
    'Participants du groupement'            as title,
    '/d_prm3_participants/prm3_participant_main_display_4.sql?prm3_id='||$prm3_id  as link;


SELECT 
    'title'     as component,
    'Groupement'    as contents,
    3           as level;

SELECT 
    'form' as component,
    '' as validate;
SELECT 
    'prm3_id' as name,
    'hidden' as type,
    $prm3_id as value,
    'id' as label;
SELECT
    'prm3_name' as name,
    TRUE as readonly,
    'Nom du groupe' as label,
     6 as width,
    (SELECT prm3_name  FROM prm3 WHERE prm3_id = $prm3_id::INTEGER ) as value;

SELECT 
    'form' as component,
    '' as validate;
SELECT 
    'prm2_sub_id' as name,
    'text' as type,
    TRUE as readonly,
    3 as width,
    :prm2_sub_id as value,
    'id' as label;
SELECT
    'prm2_sub_name' as name,
    TRUE as readonly,
    'Nom de la structure employeuse' as label,
     6 as width,
    (SELECT prm2_sub_name  FROM prm2_sub WHERE prm2_sub_id = :prm2_sub_id::INTEGER ) as value;


SELECT 
    'alert'     as component,
    'Création d''un nouveau praticipant' as title,
     TRUE              as important,
    TRUE              as dismissible,
'Pour ajouter une personne morale : entreprises, association, collectivité...' as description_md,
'red' as color;

SELECT 
    'title'   as component,
    'Ajouter un employé d''une personne morale' as contents,
    3         as level;

SELECT 
    'form'      AS component,
    'Ajouter un employé' as validate,
    '/d_prm3_participants/prm3_participant_main_attach3_0.sql?prm3_id='||$prm3_id AS action;

SELECT 
    'employee_id' as name,
    'Nom de l''employé' as label,
    'select' as type,
    8 AS width,
    TRUE as searchable,
    'Saisissez quelques lettres du nom que vous cherchez ou choississez dans la liste' as empty_option,
    json_agg(JSON_BUILD_OBJECT('label',p.prm1_first_name||'  '||p.prm1_last_name, 'value', e.employee_id)) AS options
    FROM prm2_sub_employees as e
    LEFT JOIN (SELECT prm1_id, prm1_first_name, prm1_last_name FROM prm1) as p
    on p.prm1_id = e.prm1_id
    WHERE e.prm2_sub_id = :prm2_sub_id::INTEGER;

 SELECT 
    'prm3_participant_role'            as name,
    'Rôle dans le groupement'    as label,
    'select'                       as type,
    4                              AS width,
    'Choisir un rôle...'           as empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='prm3_role';

SELECT 
    'prm2_sub_id' as name,
    'hidden' as type,
    :prm2_sub_id as value;