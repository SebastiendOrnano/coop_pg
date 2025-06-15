SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_3.sql') AS properties;

SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion Editeur'         AS title,
    '/a_panels/panel_editor_3.sql' AS link;

SELECT 
    'Gestion des organisations'            AS title,
    '/d_prm2/prm2_main_display_3.sql'      AS link;


SELECT 
    'form' AS component,
    'Créer une organization' AS title,
    'Créer' AS validate,
    'prm2_main_create_0.sql' AS action;

SELECT 
    'prm2_id' AS name,
    'hidden' AS type,
    $prm2_id AS value,
    'id' AS label;

SELECT
'prm2_name' AS name,
'text' AS type,  
'Nom' AS label,
 9 AS width,
TRUE AS required;

SELECT
'prm2_acronym' AS name,
'text' AS type,  
'Sigle' AS label,
 3 AS width;

SELECT
'prm2_punchline' AS name,
'text' AS type,  
'Punchline' AS label;

SELECT
'prm2_summary' AS name,
'textarea' AS type,  
'Pitch' AS label;

SELECT
    'file'                  AS type, 
    'prm2_logo_url'          AS name,
    'Logo'    AS label,
    'image/*' AS accept;

SELECT 
'prm2_adress' AS name,
'adress' AS label,
'text' AS type, 
'adress' AS placeholder;

SELECT 
'prm2_postal_code' AS name,
'code postal' AS label,
 3 AS width,
'text' AS type, 
'code postal' AS placeholder;

SELECT 
'prm2_town' AS name,
'ville' AS label,
'text' AS type,
 6 AS width,
'ville' AS placeholder;

SELECT 
'prm2_country' AS name,
'Pays' AS label,
'text' AS type, 
3 AS width,
'France..' AS placeholder;

SELECT 
    'prm2_contact_phone' AS name,
    'Téléphone' AS label,
    'text' AS type, 
    3 AS width,
    'téléphone' AS placeholder, 
    -- regex moins restrictive '^(?:(?:\+|00)33[\s.-]{0,3}(?:\(0\)[\s.-]{0,3})?|0)[1-9](?:(?:[\s.-]?\d{2}){4}|\d{2}(?:[\s.-]?\d{3}){2})$' AS pattern,
    '^(?:(?:\+|00)33|0)\s*[1-9] (?:[\s.-]*\d{2}){4} $' AS pattern,
    'format +33 6 00 00 00 00' AS description;

SELECT 
    'prm2_contact_mail' AS name,
    'Email' AS label,
    'text' AS type, 
    5 AS width,
    'email' AS placeholder, 
    '^[a-zA-Z0-9\.]+@[a-zA-Z0-9]+\.[a-zA-Z0-9]{2,4}$' AS pattern, 
    'format xxx.sss@xxxxx.xx' AS description;

SELECT 
'prm2_latitude' AS name,
'Latitude' AS label,
'text' AS type, 
(SELECT regex_value FROM regex WHERE regex_name='latitude')         AS pattern,
(SELECT regex_description FROM regex WHERE regex_name='latitude')          AS description,
2 AS width;

SELECT 
'prm2_longitude' AS name,
'longitude' AS label,
'text' AS type, 
(SELECT regex_value FROM regex WHERE regex_name='longitude')         AS pattern,
(SELECT regex_description FROM regex WHERE regex_name='longitude')          AS description,
2 AS width;

SELECT 
'prm2_legal_status'            AS name,
'Statut légal'                 AS label,
'select'                       AS type,
3                              AS width,
'Choisir un statut dans la liste...'    AS  empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='legal_status';

SELECT 
    'prm2_date_creation' AS name,
    'Date de création'       AS label,
    'date'                      AS type,
    3                            AS width,
    '^[0-9]{4}-(((0[13578]|(10|12))-(0[1-9]|[1-2][0-9]|3[0-1]))|(02-(0[1-9]|[1-2][0-9]))|((0[469]|11)-(0[1-9]|[1-2][0-9]|30)))$' AS pattern, 
    'format : DD-MM-YYYY'       AS description;

SELECT
'prm2_no_siret' AS name,
'text' AS type,  
'SIRET' AS label,
3 AS width;

SELECT
'prm2_no_siren' AS name,
'text' AS type,  
'SIREN' AS label,
3 AS width;

SELECT
'prm2_no_rna' AS name,
'text' AS type,  
'RNA (asso 1901)' AS label,
3 AS width;

SELECT
'prm2_no_tva_intracom' AS name,
'text' AS type,  
'N° TVA Intracom' AS label,
3 AS width;

SELECT
'prm2_code_naf_ape' AS name,
'text' AS type,  
'Code NAF APE' AS label,
3 AS width;

SELECT
'prm2_number_employees' AS name,
'text' AS type,  
'Nombre d''empoyés' AS label,
3 AS width;
















