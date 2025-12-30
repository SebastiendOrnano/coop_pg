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
    '/b_orga_dept/orga_dept_main_display_4.sql?orga_id='||$orga_id      AS link;

SELECT 
    'form' AS component,
    'Actualiser les données d''une organisation' AS title,
    'Mettre à jour' AS validate,
    'Clear' AS reset,
    '/b_orga/orga_main_update_0.sql?orga_id='||$orga_id  AS action;

 SELECT 
    'orga_status'            AS name,
    'Statut'                 AS label,
    'select'                 AS type,
    2 AS width,
    TRUE                     AS required,
    (SELECT orga_status  FROM orga WHERE orga_id = $orga_id::INTEGER ) AS value,
    'Choisir un statut dans la liste...' AS  empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='status';

SELECT
    'orga_name' AS name,
    'text' AS type,  
    'Nom' AS label,
    8 AS width,
    TRUE AS required,
    (SELECT orga_name  FROM orga WHERE orga_id = $orga_id::INTEGER ) AS value;

SELECT
    'orga_acronym' AS name,
    'text' AS type,  
    'Sigle' AS label,
    2 AS width,
    (SELECT orga_acronym  FROM orga WHERE orga_id = $orga_id::INTEGER ) AS value;

SELECT
    'orga_punchline' AS name,
    'text' AS type,  
    'Punchline' AS label,
    (SELECT orga_punchline  FROM orga WHERE orga_id = $orga_id::INTEGER ) AS value;

SELECT
    'orga_summary' AS name,
    'textarea' AS type,  
    'Pitch' AS label,
    (SELECT orga_summary  FROM orga WHERE orga_id = $orga_id::INTEGER ) AS value;

SELECT 
    'file'                  AS type, 
    'orga_logo_url'          AS name,
    'Logo'    AS label,
    'image/*' AS accept;

SELECT 
    'orga_adress' AS name,
    'adress' AS label,
    'text' AS type, 
    'adress' AS placeholder, 
    (SELECT orga_adress  FROM orga WHERE orga_id = $orga_id::INTEGER ) AS value;

SELECT 
    'orga_postal_code' AS name,
    'code postal' AS label,
    3 AS width,
    'text' AS type, 
    'code postal' AS placeholder, 
    (SELECT orga_postal_code  FROM orga WHERE orga_id = $orga_id::INTEGER ) AS value;

SELECT 
    'orga_town' AS name,
    'ville' AS label,
    'text' AS type,
    6 AS width,
    'ville' AS placeholder, 
    (SELECT orga_town  FROM orga WHERE orga_id = $orga_id::INTEGER ) AS value;

SELECT 
    'orga_country' AS name,
    'Pays' AS label,
    'text' AS type, 
    3 AS width,
    'France..' AS placeholder, 
    (SELECT orga_country  FROM orga WHERE orga_id = $orga_id::INTEGER ) AS value;

SELECT 
    'orga_contact_phone' AS name,
    'Téléphone' AS label,
    'text' AS type, 
    3 AS width,
    'téléphone' AS placeholder, 
  (SELECT regex_value FROM regex WHERE regex_name='phone')         AS pattern,
   (SELECT regex_description FROM regex WHERE regex_name='phone')          AS description,
    (SELECT orga_contact_phone  FROM orga WHERE orga_id = $orga_id::INTEGER ) AS value;

SELECT 
    'orga_contact_mail' AS name,
    'Email' AS label,
    'text' AS type, 
    5 AS width,
    'email' AS placeholder, 
  (SELECT regex_value FROM regex WHERE regex_name='email')         AS pattern,
   (SELECT regex_description FROM regex WHERE regex_name='email')          AS description,
     (SELECT orga_contact_mail  FROM orga WHERE orga_id = $orga_id::INTEGER ) AS value;

SELECT 
    'orga_latitude' AS name,
    'Latitude' AS label,
    'text' AS type, 
(SELECT regex_value FROM regex WHERE regex_name='latitude')         AS pattern,
(SELECT regex_description FROM regex WHERE regex_name='latitude')          AS description, 
    2 AS width,
    (SELECT orga_latitude::DECIMAL  FROM orga WHERE orga_id = $orga_id::INTEGER ) AS value;

SELECT 
    'orga_longitude' AS name,
    'longitude' AS label,
    'text' AS type, 
    (SELECT regex_value FROM regex WHERE regex_name='longitude')         AS pattern,
    (SELECT regex_description FROM regex WHERE regex_name='longitude')   AS description,
    2 AS width,
    (SELECT orga_longitude::DECIMAL FROM orga WHERE orga_id = $orga_id::INTEGER) AS value;

SELECT 
    'orga_legal_status'            AS name,
    'Statut légal'                 AS label,
    'select'                       AS type,
    3                              AS width,
    (SELECT orga_legal_status  FROM orga WHERE orga_id = $orga_id::INTEGER ) AS value,
    'Choisir un statut dans la liste...'    AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='legal_status';
SELECT 
    'orga_date_creation' AS name,
    'Date de création'       AS label,
    'date'                      AS type,
    (SELECT orga_date_creation  FROM orga WHERE orga_id = $orga_id::INTEGER ) AS value,
    3                            AS width,
  (SELECT regex_value FROM regex WHERE regex_name='date')         AS pattern,
   (SELECT regex_description FROM regex WHERE regex_name='date')          AS description;

SELECT
    'orga_no_siret' AS name,
    'text' AS type,  
    'SIRET' AS label,
    3 AS width,
    (SELECT orga_no_siret  FROM orga WHERE orga_id = $orga_id::INTEGER ) AS value;

SELECT
    'orga_no_siren' AS name,
    'text' AS type,  
    'SIREN' AS label,
    3 AS width,
    (SELECT orga_no_siren  FROM orga WHERE orga_id = $orga_id::INTEGER ) AS value;

SELECT
    'orga_no_rna' AS name,
    'text' AS type,  
    'RNA (asso 1901)' AS label,
    3 AS width,
    (SELECT orga_no_rna  FROM orga WHERE orga_id = $orga_id::INTEGER ) AS value;

SELECT
    'orga_no_tva_intracom' AS name,
    'text' AS type,  
    'N° TVA Intracom' AS label,
    3 AS width,
    (SELECT orga_no_tva_intracom  FROM orga WHERE orga_id = $orga_id::INTEGER ) AS value;

SELECT
    'orga_code_naf_ape' AS name,
    'text' AS type,  
    'Code NAF APE' AS label,
    3 AS width,
    (SELECT orga_code_naf_ape FROM orga WHERE orga_id = $orga_id::INTEGER ) AS value;

SELECT
    'orga_number_employees' AS name,
    'text' AS type,  
    'Nombre d''empoyés' AS label,
    3 AS width,
    (SELECT orga_number_employees FROM orga WHERE orga_id = $orga_id::INTEGER ) AS value;
