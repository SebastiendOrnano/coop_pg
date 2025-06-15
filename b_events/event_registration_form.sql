SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell.sql') AS properties;

SELECT 
    'form'                           AS component,
    'S''incrire à un événement'            AS title,
    'S''inscrire'                         AS validate,
    'Clear'                         AS reset,
    '/b_events/event_registration_create_0.sql?event_id='||$event_id AS action;

SELECT 
    'event_date'              AS name,
    'Date de l''évenement'    AS label,
    'date'                    AS type,
    (SELECT event_date FROM events WHERE event_id=$event_id::INTEGER ) AS value,
   2                         AS width,
     TRUE                     AS readonly;

SELECT
    'event_start_hour' AS name,
    'text' AS type,  
    'heure début' AS label,
    (SELECT event_start_hour FROM events WHERE event_id=$event_id::INTEGER ) AS value,
    2 AS width;

SELECT
    'event_name'          AS name,
    'text'                AS type,  
    'Nom de l''événement'                  AS label,
    8 AS width,
    TRUE                AS readonly,
    (SELECT event_name FROM events WHERE event_id=$event_id::INTEGER ) AS value;


 SELECT 
    'participant_gender'         AS name,
    'Genre'                      AS label,
    'select'                     AS type,
    2                            AS width,
    'Choisir un genre dans la liste...'    AS  empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='gender';


SELECT
    'participant_first_name' AS name,
    'text' AS type,  
    'Prénom' AS label,
    5 AS width;;

SELECT
    'participant_last_name' AS name,
    'text' AS type,  
    'Nom' AS label,
    TRUE AS required,
    5 AS width;

SELECT 
    'participant_contact_phone' AS name,
    'Téléphone' AS label,
    'text' AS type, 
    4 AS width,
    'téléphone' AS placeholder, 
    -- TRUE AS required,
   (SELECT regex_value FROM regex WHERE regex_name='phone')         AS pattern,
   (SELECT regex_description FROM regex WHERE regex_name='phone')          AS description;
-- TRUE AS required,


SELECT 
    'participant_contact_email' AS name,
    'Email' AS label,
    'text' AS type, 
    8 AS width,
    'email' AS placeholder, 
-- TRUE AS required,
   (SELECT regex_value FROM regex WHERE regex_name='email')         AS pattern,
   (SELECT regex_description FROM regex WHERE regex_name='email')          AS description;

 SELECT 
    'participant_age' AS name,
    'Age' AS label,
    'number'       AS type, 
    4 AS width,
    '18' AS description;

 SELECT 
    'participant_postal_code' AS name,
    'Code postal' AS label,
    'text'       AS type, 
    4 AS width,
    '75000' AS description;


SELECT 'participant_rgpd_validation' AS name, 
       'J''ai pris connaissance des mentiones légales et des conditions générales (voir ci-dessous) d''utilisation et j''en accepte les termes ' AS label,
       TRUE AS required,
        true        AS value,
       'switch' AS type;

SELECT 
    'alert'           AS component,
    'alert-circle'    AS icon,
    'yellow'             AS color,
    TRUE              AS important,
    TRUE              AS dismissible,
    '[Consulter les conditions générales de vente CGV ](/b_about/orga_CGV.sql)' AS description_md;














