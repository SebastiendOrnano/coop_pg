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
    'Gestion des personnes physiques'            as title,
    '/d_prm1/prm1_main_display_4.sql' as link;

SELECT 
    'form'            as component,
    'Actualiser le profil de : '|| (SELECT prm1_first_name ||'   '|| prm1_last_name FROM prm1 WHERE prm1_id=$prm1_id::INTEGER) as title ,
    'Mettre à jour le profil' as validate,
    'green'           as validate_color,
    '/d_prm1/prm1_main_update_0.sql?prm1_id='||$prm1_id as action,
    'Clear'           as reset;

SELECT 
    'prm1_gender'        as name,
    'Genre'               as label,
    'select'                as type,
    3                      AS width,
    (SELECT prm1_gender FROM prm1  WHERE prm1_id = $prm1_id::INTEGER ) as value,
    'Choisir un genre...' as empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='gender';

 SELECT 
    'prm1_category'        as name,
    'Categorie'               as label,
    'select'                as type,
    3                     AS width,
    (SELECT prm1_category FROM prm1  WHERE prm1_id = $prm1_id::INTEGER ) as value,
    'Choisir une categorie...' as empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='prm1_category';

 SELECT 
    'prm1_status'        as name,
    'Status'               as label,
    'select'                as type,
    (SELECT prm1_status FROM prm1  WHERE prm1_id = $prm1_id::INTEGER ) as value,
    3                      AS width,
    'Choisir un statut...' as empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='status';

SELECT
    'prm1_first_name' as name,
    'text' as type,  
    'Prénom' as label,
    'prénom de l''adhérent' AS placeholder,
    6 AS width,
    (SELECT prm1_first_name  FROM prm1 WHERE prm1_id = $prm1_id::INTEGER ) as value;

SELECT
    'prm1_last_name' as name,
    'text' as type,  
    'Nom' as label,
    6 AS width,
    'Nom de famille de l''adhérent' AS placeholder,
    (SELECT prm1_last_name FROM prm1 WHERE prm1_id = $prm1_id::INTEGER ) as value;

SELECT 
    'prm1_phone' as name,
    'Téléphone' as label,
    'text' as type, 
    6 AS width,
    'téléphone' AS placeholder, 

    -- regex moins restrictive '^(?:(?:\+|00)33[\s.-]{0,3}(?:\(0\)[\s.-]{0,3})?|0)[1-9](?:(?:[\s.-]?\d{2}){4}|\d{2}(?:[\s.-]?\d{3}){2})$' as pattern,
(SELECT regex_value FROM regex WHERE regex_name='phone')         AS pattern,
(SELECT regex_description FROM regex WHERE regex_name='phone')          AS description,
    (SELECT prm1_phone FROM prm1 WHERE prm1_id = $prm1_id::INTEGER ) as value;

SELECT 
    'prm1_email' as name,
    'Email' as label,
    'text' as type, 
    6 AS width,
    'email' AS placeholder, 
(SELECT regex_value FROM regex WHERE regex_name='email')         AS pattern,
(SELECT regex_description FROM regex WHERE regex_name='email')          AS description,
     (SELECT prm1_email FROM prm1 WHERE prm1_id = $prm1_id::INTEGER ) as value;

SELECT 
    'prm1_date_birthday' as name,
    'Date de naissance' as label,
    'date'       as type,
    4 AS width,
(SELECT regex_value FROM regex WHERE regex_name='date')         AS pattern,
(SELECT regex_description FROM regex WHERE regex_name='date')          AS description,
    (SELECT prm1_date_birthday FROM prm1 WHERE prm1_id = $prm1_id::INTEGER ) as value;

SELECT 
    'prm1_function' as name,
    'text' as type,
    'fonction' as label,
    'fonction ou rôle' as description,
    4 AS width,
    (SELECT prm1_function FROM prm1 WHERE prm1_id = $prm1_id::INTEGER ) as value;

SELECT 
    'prm1_cv_short' as name,
    'textarea' as type,
    'Short CV' as label,
    'Résumé du parcours et des fonctions ' as description,
    (SELECT prm1_cv_short FROM prm1 WHERE prm1_id = $prm1_id::INTEGER ) as value;

SELECT 
    'prm1_cv_long' as name,
    'textarea' as type,
    'Long CV' as label,
    'CV détaillé' as description,
    (SELECT prm1_cv_long FROM prm1 WHERE prm1_id = $prm1_id::INTEGER ) as value;


