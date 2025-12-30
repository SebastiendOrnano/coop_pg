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
    'Gestion des organisations'            AS title,
    '/d_prm2/prm2_main_display_4.sql?prm2_id='||$prm2_id      AS link;

SELECT 
    'form' AS component,
    'Actualiser les données d''une organisation' AS title,
    'Mettre à jour' AS validate,
    'Clear' AS reset,
    '/d_prm2/prm2_main_update_0.sql?prm2_id='||$prm2_id  AS action;

 SELECT 
    'prm2_status'            AS name,
    'Statut'                 AS label,
    'select'                 AS type,
    2 AS width,
    TRUE                     AS required,
    (SELECT prm2_status  FROM prm2 WHERE prm2_id = $prm2_id::INTEGER ) AS value,
    'Choisir un statut dans la liste...' AS  empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='status';

SELECT
    'prm2_name' AS name,
    'text' AS type,  
    'Nom' AS label,
    8 AS width,
    TRUE AS required,
    (SELECT prm2_name  FROM prm2 WHERE prm2_id = $prm2_id::INTEGER ) AS value;

SELECT
    'prm2_acronym' AS name,
    'text' AS type,  
    'Sigle' AS label,
    2 AS width,
    (SELECT prm2_acronym  FROM prm2 WHERE prm2_id = $prm2_id::INTEGER ) AS value;

SELECT
    'prm2_punchline' AS name,
    'text' AS type,  
    'Punchline' AS label,
    (SELECT prm2_punchline  FROM prm2 WHERE prm2_id = $prm2_id::INTEGER ) AS value;

SELECT
    'prm2_summary' AS name,
    'textarea' AS type,  
    'Pitch' AS label,
    (SELECT prm2_summary  FROM prm2 WHERE prm2_id = $prm2_id::INTEGER ) AS value;

SELECT 
    'file'                  AS type, 
    'prm2_logo_url'          AS name,
    'Logo'    AS label,
    'image/*' AS accept;

SELECT 
    'prm2_adress' AS name,
    'adress' AS label,
    'text' AS type, 
    'adress' AS placeholder, 
    (SELECT prm2_adress  FROM prm2 WHERE prm2_id = $prm2_id::INTEGER ) AS value;

SELECT 
    'prm2_postal_code' AS name,
    'code postal' AS label,
    3 AS width,
    'text' AS type, 
    'code postal' AS placeholder, 
    (SELECT prm2_postal_code  FROM prm2 WHERE prm2_id = $prm2_id::INTEGER ) AS value;

SELECT 
    'prm2_town' AS name,
    'ville' AS label,
    'text' AS type,
    6 AS width,
    'ville' AS placeholder, 
    (SELECT prm2_town  FROM prm2 WHERE prm2_id = $prm2_id::INTEGER ) AS value;

SELECT 
    'prm2_country' AS name,
    'Pays' AS label,
    'text' AS type, 
    3 AS width,
    'France..' AS placeholder, 
    (SELECT prm2_country  FROM prm2 WHERE prm2_id = $prm2_id::INTEGER ) AS value;

SELECT 
    'prm2_contact_phone' AS name,
    'Téléphone' AS label,
    'text' AS type, 
    3 AS width,
    'téléphone' AS placeholder, 
    -- regex moins restrictive '^(?:(?:\+|00)33[\s.-]{0,3}(?:\(0\)[\s.-]{0,3})?|0)[1-9](?:(?:[\s.-]?\d{2}){4}|\d{2}(?:[\s.-]?\d{3}){2})$' AS pattern,
(SELECT regex_value FROM regex WHERE regex_name='phone')         AS pattern,
(SELECT regex_description FROM regex WHERE regex_name='phone')          AS description,
    (SELECT prm2_contact_phone  FROM prm2 WHERE prm2_id = $prm2_id::INTEGER ) AS value;

SELECT 
    'prm2_contact_mail' AS name,
    'Email' AS label,
    'text' AS type, 
    5 AS width,
(SELECT regex_value FROM regex WHERE regex_name='email')         AS pattern,
(SELECT regex_description FROM regex WHERE regex_name='email')          AS description,
     (SELECT prm2_contact_mail  FROM prm2 WHERE prm2_id = $prm2_id::INTEGER ) AS value;

SELECT 
    'prm2_latitude' AS name,
    'Latitude' AS label,
    'text' AS type, 
(SELECT regex_value FROM regex WHERE regex_name='latitude')         AS pattern,
(SELECT regex_description FROM regex WHERE regex_name='latitude')          AS description, 
    2 AS width,
    (SELECT prm2_latitude  FROM prm2 WHERE prm2_id = $prm2_id::INTEGER ) AS value;

SELECT 
    'prm2_longitude' AS name,
    'longitude' AS label,
    'text' AS type, 
(SELECT regex_value FROM regex WHERE regex_name='longitude')         AS pattern,
(SELECT regex_description FROM regex WHERE regex_name='longitude')          AS description,
    2 AS width,
    (SELECT prm2_longitude  FROM prm2 WHERE prm2_id = $prm2_id::INTEGER ) AS value;

SELECT 
    'prm2_legal_status'            AS name,
    'Statut légal'                 AS label,
    'select'                       AS type,
    3                              AS width,
    (SELECT prm2_legal_status  FROM prm2 WHERE prm2_id = $prm2_id::INTEGER ) AS value,
    'Choisir un statut dans la liste...'    AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='legal_status';

SELECT 
    'prm2_date_creation' AS name,
    'Date de création'       AS label,
    'date'                      AS type,
    (SELECT prm2_date_creation  FROM prm2 WHERE prm2_id = $prm2_id::INTEGER ) AS value,
    3                            AS width,
(SELECT regex_value FROM regex WHERE regex_name='date')         AS pattern,
(SELECT regex_description FROM regex WHERE regex_name='date')          AS description;

SELECT
    'prm2_no_siret' AS name,
    'text' AS type,  
    'SIRET' AS label,
    3 AS width,
    (SELECT prm2_no_siret  FROM prm2 WHERE prm2_id = $prm2_id::INTEGER ) AS value;

SELECT
    'prm2_no_siren' AS name,
    'text' AS type,  
    'SIREN' AS label,
    3 AS width,
    (SELECT prm2_no_siren  FROM prm2 WHERE prm2_id = $prm2_id::INTEGER ) AS value;

SELECT
    'prm2_no_rna' AS name,
    'text' AS type,  
    'RNA (asso 1901)' AS label,
    3 AS width,
    (SELECT prm2_no_rna  FROM prm2 WHERE prm2_id = $prm2_id::INTEGER ) AS value;

SELECT
    'prm2_no_tva_intracom' AS name,
    'text' AS type,  
    'N° TVA Intracom' AS label,
    3 AS width,
    (SELECT prm2_no_tva_intracom  FROM prm2 WHERE prm2_id = $prm2_id::INTEGER ) AS value;

SELECT
    'prm2_code_naf_ape' AS name,
    'text' AS type,  
    'Code NAF APE' AS label,
    3 AS width,
    (SELECT prm2_code_naf_ape FROM prm2 WHERE prm2_id = $prm2_id::INTEGER ) AS value;

SELECT
    'prm2_number_employees' AS name,
    'text' AS type,  
    'Nombre d''empoyés' AS label,
    3 AS width,
    (SELECT prm2_number_employees FROM prm2 WHERE prm2_id = $prm2_id::INTEGER ) AS value;
