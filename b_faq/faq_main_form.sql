SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell.sql') AS properties;

SELECT'text' as component,
'**Conditions d''utilisation de vos données personnelles / Formulaire de contact**

*Prière de lire les [Mentions légales](/a_about/orga_legal.sql) et les [CGU](/a_about/orga_CGU.sql) avant de déposer un message.*'as contents_md;


SELECT 
    'form' as component,
    'Formulaire de contact' as title,
    'Envoyer' as validate,
    '/b_faq/faq_main_create_0.sql' as action;

SELECT 
    'contact_gender'        as name,
    'Genre'                 as label,
    'select'                as type,
    3                       AS width,
    'Choisir dans la liste...'  as empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='gender';


SELECT
    'contact_first_name'   as name,
    'text'                 as type,  
    'votre prénom'         as label,
    4                      AS width,
    TRUE                  as required,
    'votre nom'           AS placeholder;

SELECT
    'contact_last_name'   as name,
    'text'                as type,  
    'votre nom'           as label,
    5                      AS width,
    TRUE                  as required,
    'votre nom'           AS placeholder;

SELECT 
    'contact_email'         as name,
    'votre email'           as label,
    'text'                  as type, 
    'votre email'           AS placeholder, 
    TRUE                   as required,
   (SELECT regex_value FROM regex WHERE regex_name='email')         as pattern,
   (SELECT regex_description FROM regex WHERE regex_name='email')          as description;

SELECT 
    'question'                  as name,
    'text'                  as type,
    'objet de votre question'   as label,
       TRUE                   as required, 
    'doit être renseigné'       as description,
    'sujet'                     AS placeholder;

SELECT 
    'question_content'     as name,
    'textarea'             as type,
    'Votre question'      as label,
    true                  as required, 
    'Votre question : ' as value,
    'Détaillez votre question' as description;

SELECT 
    'contact_rgpd'           as name,
    'switch'                  as type,
    'J''ai pris connaissance des mentions légales et des CGU et j''en accepte les termes' as label,
    TRUE                      as required, 
    'doit être renseigné'      as description;
