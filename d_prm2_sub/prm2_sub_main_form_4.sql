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
    'Gestion des departements'            as title,
     '/d_prm2_sub/prm2_sub_main_display_4.sql?prm2_id='||$prm2_id  as link;

SELECT 
    'form'   as component,
    '' as validate;
SELECT
    'prm2_id' as name,
    TRUE as readonly,
    'Id ' as label,
    1 as width,
   $prm2_id as value;
SELECT
    'prm2_name' as name,
    TRUE as readonly,
    'Nom de l''organisation mère' as label,
    11 as width,
    (SELECT prm2_name  FROM prm2 WHERE prm2_id = $prm2_id::INTEGER ) as value;

SELECT 
    'form' as component,
    'Créer le département ou la filiale d'' organisation' as title,
    'Créer' as validate,
    'Reset' as reset,
    '/d_prm2_sub/prm2_sub_main_create_0.sql' as action;

SELECT
    'prm2_sub_name' as name,
    'text' as type,  
    'Nom du département ou de la filiale' as label,
    TRUE as required,
    8 as width,
    'Nom' AS placeholder;

SELECT
    'prm2_id' as name,
    'hidden' as type,  
    'Id' as label,
    $prm2_id as value;
   

SELECT
    'prm2_sub_acronym' as name,
    'text' as type,  
    'Sigle' as label,
    4 AS width;

SELECT
    'prm2_sub_punchline' as name,
    'text' as type,  
    'Punchline' as label;

SELECT
    'prm2_sub_summary' as name,
    'textarea' as type,  
    'Pitch' as label;

SELECT 
    'file'                  as type, 
    'prm2_sub_logo_url'          as name,
    'Logo'    as label,
    'image/*' as accept;

SELECT 
'prm2_sub_adress' as name,
'adress' as label,
'text' as type, 
'adress' AS placeholder;

SELECT 
'prm2_sub_postal_code' as name,
'code postal' as label,
 3 AS width,
'text' as type, 
'code postal' AS placeholder;

SELECT 
'prm2_sub_town' as name,
'ville' as label,
'text' as type,
 6 AS width,
'ville' AS placeholder;

SELECT 
'prm2_sub_country' as name,
'Pays' as label,
'text' as type, 
3 AS width,
'France..' AS placeholder;

SELECT 
    'prm2_sub_contact_phone' as name,
    'Téléphone' as label,
    'text' as type, 
    3 AS width,
    'téléphone' AS placeholder, 
    -- regex moins restrictive '^(?:(?:\+|00)33[\s.-]{0,3}(?:\(0\)[\s.-]{0,3})?|0)[1-9](?:(?:[\s.-]?\d{2}){4}|\d{2}(?:[\s.-]?\d{3}){2})$' as pattern,
    (SELECT regex_value FROM regex WHERE regex_name='phone')         AS pattern,
    (SELECT regex_description FROM regex WHERE regex_name='phone')          AS description;

SELECT 
    'prm2_sub_contact_mail' as name,
    'Email' as label,
    'text' as type, 
    5 AS width,
    (SELECT regex_value FROM regex WHERE regex_name='email')         AS pattern,
    (SELECT regex_description FROM regex WHERE regex_name='email')          AS description;

SELECT 
    'prm2_sub_latitude' as name,
    'Latitude' as label,
    'text' as type, 
    'latitude' AS placeholder, 
    2 as width,
    (SELECT regex_value FROM regex WHERE regex_name='latitude')         AS pattern,
    (SELECT regex_description FROM regex WHERE regex_name='latitude')          AS description;

SELECT 
    'prm2_sub_longitude' as name,
    'longitude' as label,
    'text' as type, 
    'longitude' AS placeholder,
    2 as width,
    (SELECT regex_value FROM regex WHERE regex_name='longitude')         AS pattern,
    (SELECT regex_description FROM regex WHERE regex_name='longitude')          AS description;

SELECT 
    'prm2_sub_legal_status'            as name,
    'Statut légal'                 as label,
    'select'                       as type,
    3                              AS width,
    'Choisir un statut dans la liste...'    as empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='legal_status';
SELECT 
    'prm2_sub_date_creation' as name,
    'Date de création'       as label,
    'date'                      as type,
    3                            AS width,
    '^[0-9]{4}-(((0[13578]|(10|12))-(0[1-9]|[1-2][0-9]|3[0-1]))|(02-(0[1-9]|[1-2][0-9]))|((0[469]|11)-(0[1-9]|[1-2][0-9]|30)))$' as pattern, 
    'format : DD-MM-YYYY'       as description;

SELECT
'prm2_sub_no_siret' as name,
'text' as type,  
'SIRET' as label,
3 as width;

SELECT
'prm2_sub_no_siren' as name,
'text' as type,  
'SIREN' as label,
3 as width;

SELECT
'prm2_sub_no_rna' as name,
'text' as type,  
'RNA (asso 1901)' as label,
3 as width;

SELECT
'prm2_sub_no_tva_intracom' as name,
'text' as type,  
'N° TVA Intracom' as label,
3 as width;

SELECT
'prm2_sub_code_naf_ape' as name,
'text' as type,  
'Code NAF APE' as label,
3 as width;

SELECT
'prm2_sub_number_employees' as name,
'text' as type,  
'Nombre d''empoyés' as label,
3 as width;
