SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_3.sql') AS properties;


SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion editeur'         AS title,
    '/a_panels/panel_editor_3.sql' AS link;
 SELECT 
    'Projets'            AS title,
    '/e_project/project_main_display_3.sql'     AS link;   
 SELECT 
    'Hub du projet'            AS title,
    '/e_project/project_hub_display_3.sql?project_id='||$project_id     AS link; 
SELECT 
    'Gestion des lieux'            AS title,
    '/e_project_building/building_main_display_3.sql?project_id='||$project_id     AS link;

SELECT 
    'form' AS component,
    'Créer un lieu' AS title,
    'Créer' AS validate,
    'Clear' AS reset,
    '/e_project_building/building_main_create_0.sql?project_id='||$project_id AS action;

SELECT
    'building_name' AS name,
    'text' AS type,  
    'Nom' AS label,
    9 AS width,
    TRUE AS required;

 SELECT 
    'building_status'            AS name,
    'Statut'                 AS label,
    'select'                 AS type,
    3                              AS width,
    TRUE                     AS required,
    'Choisir un statut dans la liste...'    AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='status';

SELECT
    'building_summary' AS name,
    'textarea' AS type,  
    'Présentation du lieu' AS label;

SELECT 
    'building_adress' AS name,
    'adress' AS label,
    'text' AS type, 
    'adress' AS placeholder;

SELECT 
    'building_postal_code' AS name,
    'code postal' AS label,
    3 AS width,
    'text' AS type, 
    'code postal' AS placeholder;

SELECT 
    'building_town' AS name,
    'ville' AS label,
    'text' AS type,
    6 AS width,
    'ville' AS placeholder;

SELECT 
    'building_country' AS name,
    'Pays' AS label,
    'text' AS type, 
    3 AS width,
    'France..' AS placeholder;

SELECT 
    'building_contact_phone' AS name,
    'Téléphone' AS label,
    'text' AS type, 
    3 AS width,
    'téléphone' AS placeholder, 
   (SELECT regex_value FROM regex WHERE regex_name='phone')         AS pattern,
   (SELECT regex_description FROM regex WHERE regex_name='phone')          AS description;

SELECT 
    'building_contact_mail' AS name,
    'Email' AS label,
    'text' AS type, 
    5 AS width,
    'email' AS placeholder, 
   (SELECT regex_value FROM regex WHERE regex_name='email')         AS pattern,
   (SELECT regex_description FROM regex WHERE regex_name='email')          AS description;

SELECT 
    'building_latitude' AS name,
    'Latitude' AS label,
    'text' AS type, 
   (SELECT regex_value FROM regex WHERE regex_name='latitude')         AS pattern,
   (SELECT regex_description FROM regex WHERE regex_name='latitude')          AS description,
    2 AS width;

SELECT 
    'building_longitude' AS name,
    'longitude' AS label,
    'text' AS type, 
   (SELECT regex_value FROM regex WHERE regex_name='longitude')         AS pattern,
   (SELECT regex_description FROM regex WHERE regex_name='longitude')          AS description,
    2 AS width;

 SELECT 
    'building_type'            AS name,
    'Type de lieu'                 AS label,
    'select'                       AS type,
    3                              AS width,
    'Choisir un statut dans la liste...'    AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='building_type';

 SELECT 
    'building_accessibility'            AS name,
    'Accessibilité'                 AS label,
    'select'                       AS type,
    3                              AS width,
    'Choisir un statut dans la liste...'    AS  empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='building_accessibility';


SELECT
    'building_capacity_seats' AS name,
    'number' AS type,  
    'assis' AS suffix,
    'Nombre max ' AS label,
    3 AS width;

SELECT
    'building_capacity_standup' AS name,
    'number' AS type,  
    'debout' AS suffix,
    'Nombre max ' AS label,
    3 AS width;