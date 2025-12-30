SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SET project_id = SELECT project_id FROM project_building WHERE building_id = $building_id::INTEGER;

SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion Superviseur'         AS title,
    '/a_panels/panel_supervisor_4.sql' AS link;
 SELECT 
    'Retour à la liste des projets'            AS title,
    '/e_project/project_main_display_4.sql'     AS link; 
SELECT 
    '/e_project/project_hub_display_4.sql?project_id='||$project_id    AS link,
    'orange' AS outline,
    'Retour au hub du projet'  AS title,
    'corner-up-left-double'  AS icon;
SELECT 
    '/e_project_building/building_main_display_4.sql?project_id='||$project_id    AS link,
    'orange' AS outline,
    'Retour à la liste des lieux'  AS title,
    'corner-up-left-double'  AS icon;


SELECT 
    'form' AS component,
    'Profil du lieu' AS title,
    '' AS validate,
    '/e_project_building/building_main_update_0.sql?building_id='||$building_id  AS action;

SELECT
    'building_name' AS name,
    'text' AS type,  
    'Nom' AS label,
    9 AS width,
    TRUE AS readonly,
    (SELECT building_name  FROM project_building WHERE building_id = $building_id::INTEGER ) AS value;

 SELECT 
    'building_status'        AS name,
    'Statut'                 AS label,
    'select'                 AS type,
     3                        AS width,
    TRUE AS readonly,
    (SELECT building_status  FROM project_building WHERE building_id = $building_id::INTEGER ) AS value,
    'Choisir un statut dans la liste...'    AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='status';

SELECT
    'building_summary' AS name,
    'textarea' AS type,  
    'Description générale' AS label,
        TRUE AS readonly,
    (SELECT building_summary  FROM project_building WHERE building_id = $building_id::INTEGER ) AS value;

SELECT 
    'building_adress' AS name,
    'adress' AS label,
    'text' AS type, 
    'adress' AS placeholder, 
        TRUE AS readonly,
    (SELECT building_adress  FROM project_building WHERE building_id = $building_id::INTEGER ) AS value;

SELECT 
    'building_postal_code' AS name,
    'code postal' AS label,
    3 AS width,
    'text' AS type, 
    'code postal' AS placeholder,
        TRUE AS readonly, 
    (SELECT building_postal_code  FROM project_building WHERE building_id = $building_id::INTEGER ) AS value;

SELECT 
    'building_town' AS name,
    'ville' AS label,
    'text' AS type,
    6 AS width,
    'ville' AS placeholder, 
        TRUE AS readonly,
    (SELECT building_town  FROM project_building WHERE building_id = $building_id::INTEGER ) AS value;

SELECT 
    'building_country' AS name,
    'Pays' AS label,
    'text' AS type, 
    3 AS width,
    'France..' AS placeholder, 
        TRUE AS readonly,
    (SELECT building_country  FROM project_building WHERE building_id = $building_id::INTEGER ) AS value;

SELECT 
    'building_contact_phone' AS name,
    'Téléphone' AS label,
    'text' AS type, 
    3 AS width,
    'téléphone' AS placeholder, 
        TRUE AS readonly,
   (SELECT regex_value FROM regex WHERE regex_name='phone')         AS pattern,
   (SELECT regex_description FROM regex WHERE regex_name='phone')          AS description,
   (SELECT building_contact_phone  FROM project_building WHERE building_id = $building_id::INTEGER ) AS value;

SELECT 
    'building_contact_mail' AS name,
    'Email' AS label,
    'text' AS type, 
    5 AS width,
        TRUE AS readonly,
    'email' AS placeholder, 
   (SELECT regex_value FROM regex WHERE regex_name='email')         AS pattern,
   (SELECT regex_description FROM regex WHERE regex_name='email')          AS description,
   (SELECT building_contact_mail  FROM project_building WHERE building_id = $building_id::INTEGER ) AS value;

SELECT 
    'building_latitude' AS name,
    'Latitude' AS label,
    'text' AS type, 
        TRUE AS readonly,
   (SELECT regex_value FROM regex WHERE regex_name='latitude')         AS pattern,
   (SELECT regex_description FROM regex WHERE regex_name='latitude')          AS description,
    2 AS width,
    (SELECT building_latitude  FROM project_building WHERE building_id = $building_id::INTEGER ) AS value;

SELECT 
    'building_longitude' AS name,
    'longitude' AS label,
    'text' AS type, 
        TRUE AS readonly,
   (SELECT regex_value FROM regex WHERE regex_name='longitude')         AS pattern,
   (SELECT regex_description FROM regex WHERE regex_name='longitude')          AS description,
    2 AS width,
    (SELECT building_longitude  FROM project_building WHERE building_id = $building_id::INTEGER ) AS value;

 SELECT 
    'building_type'            AS name,
    'Type de lieu'                 AS label,
    'select'                       AS type,
    3                              AS width,
        TRUE AS readonly,
    (SELECT building_type  FROM project_building WHERE building_id = $building_id::INTEGER ) AS value,
    'Choisir un type dans la liste...'    AS  empty_option,
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
        TRUE AS readonly,
    (SELECT building_accessibility  FROM project_building WHERE building_id = $building_id::INTEGER ) AS value,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='building_accessibility';

SELECT
    'building_capacity_seats' AS name,
    'number' AS type,  
    (SELECT building_capacity_seats  FROM project_building WHERE building_id = $building_id::INTEGER ) AS value,
    'Nombre max' AS label,
        TRUE AS readonly,
    'Assis' AS suffix,
    3 AS width;

SELECT
    'building_capacity_standup' AS name,
    'number' AS type,  
    (SELECT building_capacity_standup  FROM project_building WHERE building_id = $building_id::INTEGER ) AS value,
    'Nombre max' AS label,
    'debout' AS suffix,
        TRUE AS readonly,
    3 AS width;