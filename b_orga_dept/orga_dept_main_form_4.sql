SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SET orga_name = (SELECT orga_name FROM orga WHERE orga_id = $orga_id::INTEGER) ;

SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion Superviseur'         AS title,
    '/a_panels/panel_supervisor_4.sql' AS link;

SELECT 
    'Gestion des departements'            AS title,
     '/b_orga_dept/orga_dept_main_display_4.sql?orga_id='||$orga_id  AS link;

SELECT 
    'form' AS component,
    'Créer le département ou la filiale d'' organisation' AS title,
    'Créer' AS validate,
    'Reset' AS reset,
    '/b_orga_dept/orga_dept_main_create_0.sql?orga_id='||$orga_id AS action;

SELECT 
   'orga_name' AS name,
   'Nom de l''organisation mère' AS label,
    TRUE AS readonly,
    12 AS width,
   $orga_name AS value;

SELECT
    'orga_dept_name' AS name,
    'text' AS type,  
    'Nom du département ou de la filiale' AS label,
    TRUE AS required,
    8 AS width,
    'Nom' AS placeholder;

SELECT
    'orga_id' AS name,
    'hidden' AS type,  
    'Id' AS label,
    $orga_id AS value;
   

SELECT
    'orga_dept_acronym' AS name,
    'text' AS type,  
    'Sigle' AS label,
    4 AS width;

SELECT
    'orga_dept_punchline' AS name,
    'text' AS type,  
    'Punchline' AS label;

SELECT
    'orga_dept_summary' AS name,
    'textarea' AS type,  
    'Pitch' AS label;

SELECT 
    'file'                  AS type, 
    'orga_dept_logo_url'          AS name,
    'Logo'    AS label,
    'image/*' AS accept;

SELECT 
'orga_dept_adress' AS name,
'adress' AS label,
'text' AS type, 
'adress' AS placeholder;

SELECT 
'orga_dept_postal_code' AS name,
'code postal' AS label,
 3 AS width,
'text' AS type, 
'code postal' AS placeholder;

SELECT 
'orga_dept_town' AS name,
'ville' AS label,
'text' AS type,
 6 AS width,
'ville' AS placeholder;

SELECT 
'orga_dept_country' AS name,
'Pays' AS label,
'text' AS type, 
3 AS width,
'France..' AS placeholder;

SELECT 
    'orga_dept_contact_phone' AS name,
    'Téléphone' AS label,
    'text' AS type, 
    3 AS width,
    'téléphone' AS placeholder, 
  (SELECT regex_value FROM regex WHERE regex_name='phone')         AS pattern,
   (SELECT regex_description FROM regex WHERE regex_name='phone')          AS description;

SELECT 
    'orga_dept_contact_mail' AS name,
    'Email' AS label,
    'text' AS type, 
    5 AS width,
    'email' AS placeholder, 
  (SELECT regex_value FROM regex WHERE regex_name='email')         AS pattern,
   (SELECT regex_description FROM regex WHERE regex_name='email')          AS description;

SELECT 
'orga_dept_latitude' AS name,
'Latitude' AS label,
'text' AS type, 
(SELECT regex_value FROM regex WHERE regex_name='latitude')         AS pattern,
(SELECT regex_description FROM regex WHERE regex_name='latitude')          AS description,
2 AS width;

SELECT 
'orga_dept_longitude' AS name,
'longitude' AS label,
'text' AS type, 
(SELECT regex_value FROM regex WHERE regex_name='longitude')         AS pattern,
(SELECT regex_description FROM regex WHERE regex_name='longitude')          AS description,
2 AS width;

SELECT 
'orga_dept_legal_status'            AS name,
'Statut légal'                 AS label,
'select'                       AS type,
3                              AS width,
'Choisir un statut dans la liste...'    AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='legal_status';

SELECT 
    'orga_dept_date_creation' AS name,
    'Date de création'       AS label,
    'date'                      AS type,
    3                            AS width,
  (SELECT regex_value FROM regex WHERE regex_name='date')         AS pattern,
   (SELECT regex_description FROM regex WHERE regex_name='date')          AS description;

SELECT
'orga_dept_no_siret' AS name,
'text' AS type,  
'SIRET' AS label,
3 AS width;

SELECT
'orga_dept_no_siren' AS name,
'text' AS type,  
'SIREN' AS label,
3 AS width;

SELECT
'orga_dept_no_rna' AS name,
'text' AS type,  
'RNA (asso 1901)' AS label,
3 AS width;

SELECT
'orga_dept_no_tva_intracom' AS name,
'text' AS type,  
'N° TVA Intracom' AS label,
3 AS width;

SELECT
'orga_dept_code_naf_ape' AS name,
'text' AS type,  
'Code NAF APE' AS label,
3 AS width;

SELECT
'orga_dept_number_employees' AS name,
'text' AS type,  
'Nombre d''empoyés' AS label,
3 AS width;
