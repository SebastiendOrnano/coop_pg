SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;


-- Link back to the process home page
SET user_role = (
    SELECT user_role FROM users
    INNER JOIN sessions ON users.user_id = sessions.user_id
    WHERE sessions.session_token = sqlpage.cookie('session_token')
); 

SET redirect_link =
    CASE WHEN $user_role = 'supervisor' 
    THEN '/b_prm2_sub/prm3_main_display_4.sql?prm3_id='||$prm3_id
    ELSE '/b_prm2_sub/prm3_main_display_1.sql?prm3_id='||$prm3_id
END;

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
'Pour ajouter une personne physique' as description_md,
'red' as color;

SELECT 
    'title'   as component,
    'Ajouter un participant' as contents,
    3         as level;

-- Form for replying to the topic

SELECT 
    'form'      AS component,
    'Ajouter une personne physique' as validate,
    '/d_prm3_participants/prm3_participant_main_attach1_0.sql?prm3_id='||$prm3_id AS action;

SELECT 
   'prm1_id' as name,
    'Nom de la personne' as label,
    'select' as type,
    8 AS width,
    TRUE as searchable,
    'Saisissez quelques lettres du nom que vous cherchez ou choississez dans la liste' as empty_option,
    json_agg(JSON_BUILD_OBJECT('label', prm1_last_name || '   ' || prm1_first_name, 'value', prm1_id)) AS options
    FROM (
    SELECT prm1_last_name, prm1_first_name, prm1_id
    FROM prm1 
    ORDER BY prm1_last_name ASC, prm1_first_name ASC
    );

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