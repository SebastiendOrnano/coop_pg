SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SET space_id = (SELECT space_id FROM place_spaces_pictures WHERE space_picture_id = $space_picture_id::INTEGER) ;
SET place_id = (SELECT place_id FROM place_spaces WHERE space_id = $space_id::INTEGER) ;

SELECT 
    'breadcrumb' as component;
SELECT 
    'Home' as title,
    '/'    as link;
SELECT 
    'Gestion Superviseur'                 as title,
    '/a_panels/panel_supervisor_4.sql'   as link;
SELECT 
    'liste des salles actives'                     as title,
    '/b_orga_places/orga_place_main_display_4.sql' as link;
SELECT 
    'Salle de rattachement'                     as title,
    '/b_orga_place_spaces/orga_place_space_main_display_4.sql?place_id='||$place_id  as link;


SET space_picture_url = SELECT space_picture_url FROM place_spaces_pictures WHERE space_picture_id=$space_picture_id::INTEGER;

SELECT
    'card' as component,
   5    as columns;

SELECT
   2 as width,
   $space_picture_url as top_image,
   $space_picture_url AS link;

SELECT 
    'form' AS component,
    '' AS validate;

SELECT
    'place_name' AS name,
    TRUE AS readonly,
    'text' AS type,
    'Nom du Bâtiment' AS label,
    6 AS width,
    (SELECT place_name  FROM place WHERE place_id = place_id::INTEGER ) AS value;
SELECT
    'space_name' AS name,
    TRUE AS readonly,
        'text' AS type,
    'Nom de la pièce' AS label,
    6 AS width,
    (SELECT space_name  FROM place_spaces WHERE space_id = $space_id::INTEGER ) AS value;

SELECT
    'space_picture_title' AS name,
    'text' AS type,  
    'Nom' AS label,
    (SELECT space_picture_title FROM place_spaces_pictures WHERE space_picture_id=$space_picture_id::INTEGER ) AS value,
    12 AS width,
    TRUE AS readonly;

SELECT 
    'space_picture_status'            AS name,
    'Statut'                 AS label,
    'text'                 AS type,
    3                              AS width,
    TRUE AS readonly,
    (SELECT space_picture_status FROM place_spaces_pictures WHERE space_picture_id=$space_picture_id::INTEGER ) AS value,
    'Choisir un statut dans la liste...'    AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='status';

SELECT 
    'space_picture_format'            AS name,
    'Format'                 AS label,
    'text'                       AS type,
    3                              AS width,
    TRUE AS readonly,
    (SELECT space_picture_format FROM place_spaces_pictures WHERE space_picture_id=$space_picture_id::INTEGER ) AS value,
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
    (SELECT space_picture_summary FROM place_spaces_pictures WHERE space_picture_id=$space_picture_id::INTEGER ) AS description_md;



















