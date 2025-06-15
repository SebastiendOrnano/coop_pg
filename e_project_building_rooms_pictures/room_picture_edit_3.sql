SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_3.sql') AS properties;

SET room_id = (SELECT room_id FROM project_building_rooms_pictures WHERE room_picture_id = $room_picture_id::INTEGER) ;
SET building_id = (SELECT building_id FROM project_building_rooms WHERE room_id = $room_id::INTEGER) ;
SET project_id = (SELECT project_id FROM project_building WHERE building_id = $building_id::INTEGER) ;


select 
    'breadcrumb' as component;
select 
    'Home' as title,
    '/'    as link;
select 
    'Gestion éditeur'         as title,
    '/a_panels/panel_editor_3.sql' as link;
 select 
    'hub du projet'            as title,
    '/e_project/project_hub_display_3.sql?project_id='||$project_id     as link;  
select 
    '/e_project_building_rooms/room_main_display_3.sql?building_id='||$building_id    as link,
    'liste des lieux'  as title;
select 
    '/e_project_building_rooms_pictures/room_picture_display_3.sql?room_id='||$room_id    as link,
    'gestion des photos de la pièce'  as title;




SELECT 
    'form'   AS component,
    '' AS validate;
SELECT
    'building_id' AS name,
    TRUE AS readonly,
    'Id ' AS label,
    1 AS width,
     $building_id AS value;
SELECT
    'building_name' AS name,
    TRUE AS readonly,
    'Nom du Bâtiment' AS label,
    5 AS width,
    (SELECT building_name  FROM project_building WHERE building_id = $building_id::INTEGER ) AS value;
SELECT
    'room_id' AS name,
    TRUE AS readonly,
    'Id ' AS label,
    1 AS width,
    $room_id AS value;
SELECT
    'room_name' AS name,
    TRUE AS readonly,
    'Nom de la pièce' AS label,
    5 AS width,
    (SELECT room_name  FROM project_building_rooms WHERE room_id = $room_id::INTEGER ) AS value;

SELECT 
    'form' AS component,
    'Actualiser une image liée une salle' AS title,
    'Actualiser' AS validate,
    'Clear' AS reset,
    '/e_project_building_rooms_pictures/room_picture_update_0.sql?room_picture_id='||$room_picture_id AS action;

SELECT 
    'room_id' AS name,
    'hidden' AS type,
    $room_id AS value,
    'id' AS label;

SELECT
    'room_picture_title' AS name,
    'text' AS type,  
    'Nom' AS label,
    (SELECT room_picture_title FROM project_building_rooms_pictures WHERE room_picture_id=$room_picture_id::INTEGER ) AS value,
    6 AS width,
    TRUE AS required;

SELECT 
    'room_picture_status'            AS name,
    'Statut'                 AS label,
    'select'                 AS type,
    3                              AS width,
    TRUE                     AS required,
    (SELECT room_picture_status FROM project_building_rooms_pictures WHERE room_picture_id=$room_picture_id::INTEGER ) AS value,
    'Choisir un statut dans la liste...'    AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='status';

SELECT 
    'room_picture_format'            AS name,
    'Format'                 AS label,
    'select'                       AS type,
    3                              AS width,
    (SELECT room_picture_format FROM project_building_rooms_pictures WHERE room_picture_id=$room_picture_id::INTEGER ) AS value,
    'Choisir un format dans la liste...'    AS  empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='img_format';

SELECT 
    'file' AS type, 
    'room_picture_url' AS name,
    'Photo à insérer' AS label,
    'image/*' AS accept;

SELECT
    'room_summary' AS name,
    'textarea' AS type,
    (SELECT room_picture_summary FROM project_building_rooms_pictures WHERE room_picture_id=$room_picture_id::INTEGER ) AS value,
    'Disposition, équipement, lumière...' AS description,
    'Présentation de la salle' AS label;






















