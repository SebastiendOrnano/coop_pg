SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_1.sql') AS properties;

SET user_id = (
    SELECT users.user_id FROM users
    INNER JOIN sessions AS s ON users.user_id = s.user_id
    WHERE s.session_token = sqlpage.cookie('session_token')
); 


SELECT'text' as component,
'**Votre question sera lue par le superviseur et éventuellement ajoutée à la FAQ interne**

*Rappel : Prière de lire les [Mentions légales](/a_about/orga_legal.sql) et les [CGU](/a_about/orga_CGU.sql) avant de déposer un message.*'as contents_md;


SELECT 
    'form'                 as component,
    'Votre question'        as title,
    'Envoyer'               as validate,
    '/b_faq/faq_main_create_0.sql' as action;

SELECT 
    'contact_gender'        as name,
    'Genre'                 as label,
    'text'                as type,
    true                    as readonly,
    (SELECT user_gender FROM users WHERE user_id=$user_id::INTEGER ) as value,
    3                       AS width,
    'Choisir un genre...'  as empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='gender';
SELECT
    'contact_first_name'   as name,
    'text'                 as type,  
    'votre prénom'         as label,
    true                    as readonly,
    (SELECT user_first_name FROM users WHERE user_id=$user_id::INTEGER ) as value,
    4                       AS width,
    TRUE                    as required,
    'votre nom'            AS placeholder;

SELECT
    'contact_last_name'   as name,
    'text'                as type,  
    'votre nom'           as label,
    5                      AS width,
    true                    as readonly,
    (SELECT user_last_name FROM users WHERE user_id=$user_id::INTEGER ) as value,
    TRUE                  as required,
    'votre nom'           AS placeholder;

SELECT 
    'contact_email'         as name,
    'votre email'           as label,
    'text'                  as type, 
    'votre email'           AS placeholder, 
    true                    as readonly,
    (SELECT user_email FROM users WHERE user_id=$user_id::INTEGER ) as value,
    TRUE                   as required,
   (SELECT regex_value FROM regex WHERE regex_name='email')         as pattern,
   (SELECT regex_description FROM regex WHERE regex_name='email')          as description;

SELECT 
    'question'                 as name,
    'text'                 as type,
    'objet de votre question'  as label,
    'doit être renseigné'       as description,
    TRUE                        as required ;

SELECT 
    'question_content'     as name,
   'textarea' as type,
    'Votre question'      as label,
    true                  as required, 
    'Votre question : ' as value,
    'doit être renseigné' as description;