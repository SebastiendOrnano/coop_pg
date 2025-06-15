SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion Superviseur'         AS title,
 '/a_panels/panel_supervisor_4.sql' AS link;
SELECT 
    'Gestion des membres'            AS title,
    '/b_members/member_main_display_4.sql' AS link;
SELECT 
    'Gestion de sélections de membres'            AS title,
    '/b_members/member_select_display_4.sql' AS link;

SELECT 
    'form'                                                      AS component,
    'Actualisation des données des membres sélectionnés'        AS title ,
    'Actualiser les données de la sélection'                    AS validate,
    'green'                                                     AS validate_color,
    '/b_members/member_select_update_0.sql'                     AS action,
    'Clear'                                                     AS reset;


SELECT 
    'member_gender'        AS name,
    'Genre'               AS label,
    'select'                AS type,
    3                      AS width,
    'Choisir un genre...' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='gender';


 SELECT 
    'member_category'        AS name,
    'Categorie'               AS label,
    'select'                AS type,
    3                     AS width,
    'Choisir une categorie...' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='member_category';

 SELECT 
    'member_status'        AS name,
    'Status'               AS label,
    'select'                AS type,
    3                      AS width,
    'Choisir un statut...' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='status';

SELECT 
    'member_publish'        AS name,
    'Public/privé'               AS label,
    'select'                AS type,
    3                     AS width,
    'Profil public ou caché...' AS empty_option,
    '[
    {"label": "Public", "value": true},
    {"label": "Privé", "value": false}
    ]' AS options;



SELECT 
    'member_date_since' AS name,
    'Membre depuis'     AS label,
    'date'              AS type,
    4                   AS width,
   (SELECT regex_value FROM regex WHERE regex_name='date')         AS pattern,
   (SELECT regex_description FROM regex WHERE regex_name='date')          AS description;

SELECT 
    'member_date_last_subscription' AS name,
    'Dernière date cotisation'      AS label,
    'date'                          AS type,
    4                               AS width,
   (SELECT regex_value FROM regex WHERE regex_name='date')         AS pattern,
   (SELECT regex_description FROM regex WHERE regex_name='date')          AS description;

SELECT 
    'member_function'       AS name,
    'text'                  AS type,
    'fonction'              AS label,
    'fonction ou rôle dans l''organisation' AS description,
    'directeur ou chargé de mission' AS placeholder,
     4                      AS width;

    
