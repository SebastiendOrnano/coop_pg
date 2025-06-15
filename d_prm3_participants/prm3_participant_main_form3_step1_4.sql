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
    'alert'     as component,
    'Création d''un nouveau praticipant' as title,
     TRUE              as important,
    TRUE              as dismissible,
'Pour ajouter une personne morale : entreprises, association, collectivité...' as description_md,
'red' as color;

SELECT 
    'title'   as component,
    'Ajouter un employé - step 1 : choisir l''employeur' as contents,
    3         as level;

SELECT 
    'form'      AS component,
    'Choisir l''entreprise' as validate,
    '/d_prm3_participants/prm3_participant_main_form3_step2_4.sql?prm3_id='||$prm3_id AS action;

SELECT 
   'prm2_sub_id' as name,
    'Choisir l''entreprise employeur' as label,
    'select' as type,
    8 AS width,
    TRUE as searchable,
    'Saisissez quelques lettres du nom que vous cherchez ou choississez dans la liste' as empty_option,
    json_agg(JSON_BUILD_OBJECT('label',prm2_sub_name, 'value', prm2_sub_id)) AS options
    FROM (
    SELECT prm2_sub_name, prm2_sub_id
    FROM prm2_sub 
    ORDER BY prm2_sub_name ASC
    );

