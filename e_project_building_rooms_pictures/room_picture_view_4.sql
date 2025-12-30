SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SET room_id = (SELECT room_id FROM project_building_rooms_pictures WHERE room_picture_id = $room_picture_id::INTEGER) ;
SET building_id = (SELECT building_id FROM project_building_rooms WHERE room_id = $room_id::INTEGER) ;
SET project_id = (SELECT project_id FROM project_building WHERE building_id = $building_id::INTEGER) ;
SET workpackage_id = (SELECT workpackage_id FROM project_building_rooms_pictures WHERE room_picture_id=$room_picture_id::INTEGER );
SET worksequence_id = (SELECT worksequence_id FROM project_building_rooms_pictures WHERE room_picture_id=$room_picture_id::INTEGER );


SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion superviseur'         AS title,
    '/a_panels/panel_supervisor_4.sql' AS link;
 SELECT 
    'hub du projet'            AS title,
    '/e_project/project_hub_display_4.sql?project_id='||$project_id     AS link;
SELECT
    'Bâtiment du projet'            AS title,
    '/e_project_building/building_main_display_4.sql?project_id='||$project_id     AS link;
SELECT 
    '/e_project_building_rooms/room_main_display_4.sql?building_id='||$building_id    AS link,
    'Pièces du bâtiments'  AS title;
select 
    '/e_project_building_rooms_pictures/building_picture_display_4.sql?building_id='||$building_id   as link,
    'Photos du bâtiment'  as title;


SELECT 
    'datagrid'              AS component,
    'Galerie des photos du projet  :'||$project_name        AS title;
SELECT 
    p.room_picture_title               AS title,
    p.room_picture_url                 AS link,
    p.room_picture_url                 AS image_url,
    'Cliquez pour agrandir'            AS tooltip
 FROM project_building_rooms_pictures     AS p
 WHERE room_picture_id=$room_picture_id::INTEGER;



SELECT 
    'form' AS component,
    '' AS validate;

SELECT
    'building_name' AS name,
    TRUE AS readonly,
    'text' AS type,
    'Nom du Bâtiment' AS label,
    6 AS width,
    (SELECT building_name  FROM project_building WHERE building_id = $building_id::INTEGER ) AS value;
SELECT
    'room_name' AS name,
    TRUE AS readonly,
        'text' AS type,
    'Nom de la pièce' AS label,
    6 AS width,
    (SELECT room_name  FROM project_building_rooms WHERE room_id = $room_id::INTEGER ) AS value;
SELECT 
    'workpackage_id' AS name,
    'ID lot' AS label,
    'text' AS type,
    TRUE AS readonly,
    1 AS width,
    TRUE AS searchable,
    (SELECT workpackage_id FROM project_building_rooms_pictures WHERE room_picture_id=$room_picture_id::INTEGER ) AS value;
SELECT 
    'workpackage_name' AS name,
    'lot de travaux' AS label,
    'text' AS type,
    TRUE AS readonly,
    4 AS width,
    (SELECT workpackage_name 
    FROM project_workpackage as w 
    LEFT JOIN (select  workpackage_id, room_picture_id FROM project_building_rooms_pictures) as p 
    ON p.workpackage_id=w.workpackage_id
    WHERE p.room_picture_id=$room_picture_id::INTEGER ) AS value;

SELECT 
    'worksequence_id' AS name,
    'ID seq' AS label,
    'text' AS type,
    1 AS width,
    TRUE AS readonly,
   (select  worksequence_id FROM project_building_rooms_pictures  WHERE room_picture_id=$room_picture_id::INTEGER ) AS value;

SELECT 
    'worksequence_name' AS name,
    'ID seq' AS label,
    'text' AS type,
    4 AS width,
    TRUE AS readonly,
    (SELECT worksequence_name FROM project_worksequence as s 
    LEFT JOIN (select  worksequence_id, room_picture_id FROM project_building_rooms_pictures) as p 
    ON p.worksequence_id=s.worksequence_id
    WHERE p.room_picture_id=$room_picture_id::INTEGER ) AS value;

SELECT
    'room_picture_title' AS name,
    'text' AS type,  
    'Nom' AS label,
    (SELECT room_picture_title FROM project_building_rooms_pictures WHERE room_picture_id=$room_picture_id::INTEGER ) AS value,
    12 AS width,
    TRUE AS readonly;

SELECT 
    'room_picture_status'            AS name,
    'Statut'                 AS label,
    'text'                 AS type,
    3                              AS width,
    TRUE AS readonly,
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
    'text'                       AS type,
    3                              AS width,
    TRUE AS readonly,
    (SELECT room_picture_format FROM project_building_rooms_pictures WHERE room_picture_id=$room_picture_id::INTEGER ) AS value,
    'Choisir un format dans la liste...'    AS  empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='img_format';


SELECT
    'foldable' AS component;
SELECT
    'Commentaires' as title,
    (SELECT room_picture_summary FROM project_building_rooms_pictures WHERE room_picture_id=$room_picture_id::INTEGER ) AS description_md;



















