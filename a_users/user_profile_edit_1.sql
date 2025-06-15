SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_1.sql') AS properties;

SELECT 
    'form'            AS component,
    'Mon profil'            AS title,
    'Mettre à jour mon profil' AS validate,
    'green'           AS validate_color,
    '/a_users/user_profile_update_0.sql?user_id='||$user_id AS action,
    'Clear'           AS reset;

SELECT 
    'username' AS name,
    'Nom d''utilisateur' AS label,
    'Doe'       AS placeholder,
    TRUE AS readonly,
    (SELECT username FROM users WHERE user_id=$user_id::INTEGER ) AS value,
    12          AS width;

 SELECT 
    'user_gender'        AS name,
    'Genre'               AS label,
    'select'                AS type,
    (SELECT user_gender FROM users WHERE user_id=$user_id::INTEGER ) AS value,
    2                     AS width,
    'Choisir un genre...' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='gender';


SELECT 
    'user_first_name' AS name,
    'Prénom' AS label,
    'text' AS type,
    'jean'  AS placeholder,
    (SELECT user_first_name FROM users WHERE user_id=$user_id::INTEGER ) AS value,
    4            AS width;

SELECT 
    'user_last_name' AS name,
    'Nom de famille' AS label,
    'text' AS type,
    'Dupont'       AS placeholder,
    (SELECT user_last_name FROM users WHERE user_id=$user_id::INTEGER ) AS value,
    4            AS width;

SELECT
    'user_phone' AS name,
    'text' AS type, 
    3 AS width,
    (SELECT user_phone FROM users WHERE user_id=$user_id::INTEGER ) AS value,
    (SELECT regex_value FROM regex WHERE regex_name='phone')         AS pattern,
    (SELECT regex_description FROM regex WHERE regex_name='phone')          AS description;

SELECT 
    'user_lang'                   AS name,
    'Langue'      AS label,
    'select'                     AS type,
    3                            AS width,
    (SELECT user_level FROM users WHERE user_id=$user_id::INTEGER ) AS value,
    'Choisir une langue dans la liste...'    AS  empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='lang';


SELECT 
    'user_short_cv' AS name,
    'textarea' AS type, 
    'Qui êtes-vous ?'as label,
    12 AS width,
    (SELECT user_short_cv FROM users WHERE user_id=$user_id::INTEGER ) AS value,
    'Une courte description de vos fonctions et votre parcours en lien avec la plate-forme Co-Op' AS placeholder;


    
