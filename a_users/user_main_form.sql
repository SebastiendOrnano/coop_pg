SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell.sql') AS properties;


SELECT 
     'form'                               AS component,
    'Créer un nouveau compte utilisateur' AS title,
    'Créer le compte'                     AS validate,
    'Clear'                               AS rest,
    '/a_users/user_main_create_0.sql'     AS action;

SELECT 
    'username'           AS name,
    'nom d''utilisateur' AS label,
    TRUE                 AS required;

 SELECT 
    'user_gender'         as name,
    'Genre'               as label,
    'select'              as type,
    2                     AS width,
    'Choisir un genre...' as empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='gender';

SELECT 
    'user_last_name'      AS name,
    5                     AS width,
    TRUE                  AS required,
    'nom de famille'      AS label;

SELECT 
    'user_first_name'     AS name,
    5                     AS width,
    TRUE                  AS required,
    'prénom'              AS label;

SELECT 
    'user_email'          AS name,
    'email'               AS label,
    8                     AS width,
    'text'                AS type,
    TRUE                  AS required,
   (SELECT regex_value FROM regex WHERE regex_name='email')         as pattern,
   (SELECT regex_description FROM regex WHERE regex_name='email')          as description;

SELECT 
    'user_phone'           AS name,
    'n° téléphone contact' AS label,
    'text'                 as type, 
    4                      AS width,
    'téléphone'            AS placeholder, 
    '+33 6'                as value,
    (SELECT regex_value FROM regex WHERE regex_name='phone')         as pattern,
    (SELECT regex_description FROM regex WHERE regex_name='phone')          as description;


SELECT 
    'password'                               AS name, 
    'password'                               AS type,
    'Mot de passe'                          AS label,
    TRUE                                     AS required,
    --'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$' as pattern,
 --
   
    (SELECT regex_value FROM regex WHERE regex_name='password')         as pattern,
    (SELECT regex_description FROM regex WHERE regex_name='password')          as description;

SELECT 
   'password_check'                          AS name, 
   'password'                                AS type,
   'Contrôle du mot de passe'                AS label,
    TRUE                                     AS required,
    (SELECT regex_value FROM regex WHERE regex_name='password')         as pattern,
    (SELECT regex_description FROM regex WHERE regex_name='password')          as description;

SELECT 
    'user_short_cv'            AS name,
    'Qui êtes-vous ?'          as label,
    'textarea'                 as type, 
    'Une courte description de vos fonctions et votre parcours en lien avec la plate-forme Co-Op' AS placeholder,
    TRUE                      AS required, 
    'textarea'                AS type;

SELECT 
    'user_lang'          as name,
    'radio'              as type,
    'FR'                 as value,
    'Français'           as label,
    2                    AS width;

SELECT 
    'user_lang'           as name,
    'radio'               as type,
    'EN'                  as value,
    'English'             as label,
     2                    AS width;

SELECT 
    'rgpd_validation' AS name, 
    'J''ai pris connaissance des mentiones légales et des conditions générales (voir ci-dessous) d''utilisation et j''en accepte les termes ' AS label,
    TRUE AS required,
    true        as value,
    'checkbox' AS type;

SELECT 
    'alert'           as component,
    'alert-circle'    as icon,
    'yellow'          as color,
    TRUE              as important,
    TRUE              as dismissible,
    '[Consulter les termes d''utilisation de la plateforme](/b_about/orga_CGU.sql)' as description_md;
