SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SET prm3_id= SELECT prm3_id FROM prm3_participants WHERE prm3_participant_id=$prm3_participant_id::INTEGER;


SELECT 
    'breadcrumb' as component;
SELECT 
    'Home' as title,
    '/'    as link;
SELECT 
    'Gestion Superviseur'         as title,
    '/a_panels/panel_supervisor_4.sql' as link;
SELECT 
    'Gestion des groupements'    as title,
    '/d_prm3/prm3_main_display_4.sql'  as link;
SELECT 
    'Gestion des participants'            as title,
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
    'title'     as component,
    'Participant'    as contents,
    3           as level;

SELECT 
    'form'      AS component,
    'Actualiser un participant' as validate,
    '/d_prm3_participants/prm3_participant_main_update_0.sql?prm3_participant_id='||$prm3_participant_id||'&prm3_id='||$prm3_id AS action;

SELECT 
   'prm1_id' as name,
    'Personne (non modifiable)' as label,
    'text' as type,
     TRUE as readonly,
    6 AS width,
    (SELECT  i.prm1_last_name || '   ' || i.prm1_first_name
    FROM prm3_participants as p
    LEFT JOIN (SELECT prm1_id, prm1_first_name, prm1_last_name FROM prm1) as i
    ON p.prm1_id = i.prm1_id
    WHERE p.prm3_participant_id=$prm3_participant_id::INTEGER ) as value ;

SELECT 
   'prm2_sub_id' as name,
    'Entreprise (non modifiable)' as label,
    'text' as type,
    TRUE as readonly,
    6 AS width,
    (SELECT  c.prm2_sub_name FROM prm3_participants as p
    LEFT JOIN (SELECT prm2_sub_id, prm2_sub_name FROM prm2_sub) as c
    ON p.prm2_sub_id = c.prm2_sub_id 
    WHERE p.prm3_participant_id=$prm3_participant_id::INTEGER ) as value ;

SELECT 
    'prm3_participant_role'            as name,
    'Rôle dans le groupement'    as label,
    'select'                       as type,
    4                              AS width,
    (SELECT prm3_participant_role FROM prm3_participants WHERE prm3_participant_id=$prm3_participant_id::INTEGER ) as value,
    'Choisir un rôle...'           as empty_option,
    '[
    {"label": "Pilote", "value": "pilot"},
    {"label": "Coordinateur", "value": "coordinator"},
    {"label": "Encadrant technique", "value": "technical"},
    {"label": "formateur", "value": "coach"},
    {"label": "Représentant legal", "value": "legal"},
    {"label": "Responsable finance", "value": "finance"},
    {"label": "Responsable commercial", "value": "commercial"},
    {"label": "Autre", "value": "N"}
    ]' as options;

SELECT 
    'prm3_participant_status'      as name,
    'Statut actif-archive'          as label,
    'select'                       as type,
    4                              AS width,
    (SELECT prm3_participant_status FROM prm3_participants WHERE prm3_participant_id=$prm3_participant_id::INTEGER ) as value,
    'Choisir un statut dans la liste...'    as  empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='prm3_category';