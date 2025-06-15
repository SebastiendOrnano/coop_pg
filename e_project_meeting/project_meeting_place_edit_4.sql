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
    'Retour à la liste des projets'            AS title,
    '/e_project/project_main_display_4.sql'     AS link;   
 SELECT 
    'Retour à la liste des lieux de réunion'            AS title,
    '/e_project_meeting/project_meeting_place_display_4.sql'     AS link;

SELECT 
    'form' AS component,
    'Actualiser les données d''une salle' AS title,
    'Mettre à jour' AS validate,
    'Clear' AS reset,
    '/e_project_meeting/project_meeting_place_update_0.sql?project_meeting_place_id='||$project_meeting_place_id  AS action;

SELECT
    'project_meeting_place_name' AS name,
    'text' AS type,  
    'Nom' AS label,
    9 AS width,
    TRUE AS required,
    (SELECT project_meeting_place_name  FROM project_meeting_places WHERE project_meeting_place_id = $project_meeting_place_id::INTEGER ) AS value;

 SELECT 
    'project_meeting_place_status'            AS name,
    'Statut'                 AS label,
    'select'                 AS type,
    3                         AS width,
    TRUE                     AS required,
    (SELECT project_meeting_place_status  FROM project_meeting_places WHERE project_meeting_place_id = $project_meeting_place_id::INTEGER ) AS value,
    'Choisir un statut dans la liste...'    AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='status';

SELECT
'project_meeting_place_summary' AS name,
'textarea' AS type,  
'Pitch' AS label,
(SELECT project_meeting_place_summary  FROM project_meeting_places WHERE project_meeting_place_id = $project_meeting_place_id::INTEGER ) AS value;

SELECT 
'project_meeting_place_adress' AS name,
'adress' AS label,
'text' AS type, 
'adress' AS placeholder, 
(SELECT project_meeting_place_adress  FROM project_meeting_places WHERE project_meeting_place_id = $project_meeting_place_id::INTEGER ) AS value;

SELECT 
'project_meeting_place_postal_code' AS name,
'code postal' AS label,
 3 AS width,
'text' AS type, 
'code postal' AS placeholder, 
(SELECT project_meeting_place_postal_code  FROM project_meeting_places WHERE project_meeting_place_id = $project_meeting_place_id::INTEGER ) AS value;

SELECT 
'project_meeting_place_town' AS name,
'ville' AS label,
'text' AS type,
 6 AS width,
'ville' AS placeholder, 
(SELECT project_meeting_place_town  FROM project_meeting_places WHERE project_meeting_place_id = $project_meeting_place_id::INTEGER ) AS value;

SELECT 
'project_meeting_place_country' AS name,
'Pays' AS label,
'text' AS type, 
3 AS width,
'France..' AS placeholder, 
(SELECT project_meeting_place_country  FROM project_meeting_places WHERE project_meeting_place_id = $project_meeting_place_id::INTEGER ) AS value;

SELECT 
    'project_meeting_place_contact_phone' AS name,
    'Téléphone' AS label,
    'text' AS type, 
    3 AS width,
    'téléphone' AS placeholder, 
  (SELECT regex_value FROM regex WHERE regex_name='phone')         AS pattern,
   (SELECT regex_description FROM regex WHERE regex_name='phone')          AS description,
    (SELECT project_meeting_place_contact_phone  FROM project_meeting_places WHERE project_meeting_place_id = $project_meeting_place_id::INTEGER ) AS value;

SELECT 
    'project_meeting_place_contact_mail' AS name,
    'Email' AS label,
    'text' AS type, 
    5 AS width,
    'email' AS placeholder, 
  (SELECT regex_value FROM regex WHERE regex_name='email')         AS pattern,
   (SELECT regex_description FROM regex WHERE regex_name='email')          AS description,
     (SELECT project_meeting_place_contact_mail  FROM project_meeting_places WHERE project_meeting_place_id = $project_meeting_place_id::INTEGER ) AS value;

SELECT 
'project_meeting_place_latitude' AS name,
'Latitude' AS label,
'text' AS type, 
'latitude' AS placeholder, 
2 AS width,
(SELECT project_meeting_place_latitude  FROM project_meeting_places WHERE project_meeting_place_id = $project_meeting_place_id::INTEGER ) AS value;

SELECT 
'project_meeting_place_longitude' AS name,
'longitude' AS label,
'text' AS type, 
'longitude' AS placeholder,
2 AS width,
(SELECT project_meeting_place_longitude  FROM project_meeting_places WHERE project_meeting_place_id = $project_meeting_place_id::INTEGER ) AS value;


 
 SELECT 
'project_meeting_place_type'            AS name,
'Type de lieu'                 AS label,
'select'                       AS type,
3                              AS width,
(SELECT project_meeting_place_type  FROM project_meeting_places WHERE project_meeting_place_id = $project_meeting_place_id::INTEGER ) AS value,
'Choisir un type dans la liste...'    AS  empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='project_meeting_place_type';


 SELECT 
'project_meeting_place_accessibility'            AS name,
'Accessibilité'                 AS label,
'select'                       AS type,
3                              AS width,
(SELECT project_meeting_place_accessibility  FROM project_meeting_places WHERE project_meeting_place_id = $project_meeting_place_id::INTEGER ) AS value,
'Choisir un statut dans la liste...'    AS  empty_option,
'[{"label": "Accessible", "value": true},
{"label": "Non accessible", "value": false},
{"label": "Non précisé", "value": "N"}
]'  AS options;


SELECT
'project_meeting_place_capacity_seats' AS name,
'number' AS type,  
(SELECT project_meeting_place_capacity_seats  FROM project_meeting_places WHERE project_meeting_place_id = $project_meeting_place_id::INTEGER ) AS value,
'Nombre max' AS label,
'Assis' AS suffix,
3 AS width;

SELECT
'project_meeting_place_capacity_standup' AS name,
'number' AS type,  
(SELECT project_meeting_place_capacity_standup  FROM project_meeting_places WHERE project_meeting_place_id = $project_meeting_place_id::INTEGER ) AS value,
'Nombre max' AS label,
'debout' AS suffix,
3 AS width;