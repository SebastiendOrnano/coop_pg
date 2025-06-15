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
    'liste des projets'            as title,
    '/e_project/project_main_display_4.sql'     as link;   
 SELECT 
    'hub du projet'            as title,
    '/e_project/project_hub_display_4.sql?project_id='||$project_id     as link;   
 SELECT 
    'bâtiments du projet'            as title,
    '/e_project_building/building_main_display_4.sql?project_id='||$project_id     as link;    
SELECT 
    'lieu de rattachement'            as title,
    '/e_project_building_rooms/room_main_display_3.sql?building_id='||$building_id     as link;

SELECT 
    'form' as component,
    'Créer une salle' as title,
    'Créer' as validate,
    'Clear' as reset,
    '/e_project_building_rooms/room_main_create_0.sql?building_id='||$building_id as action;

SELECT
    'room_name' as name,
    'text' as type,  
    'Nom' as label,
    6 AS width,
    TRUE as required;


 SELECT 
    'room_type'            as name,
    'Nature de la salle'                 as label,
    'select'                       as type,
    3                              AS width,
    'Choisir la nature de la salle dans la liste...'    as  empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='room_type';

SELECT
    'room_summary' as name,
    'textarea' as type,
    'Disposition, équipement, lumière...' as description,
    'Présentation de la salle' as label;

SELECT
    'room_todo' as name,
    'textarea' as type,
    'Travaux à faire...' as description,
    'Travaux à faire' as label;

 SELECT 
    'room_quality_level'                as name,
    'État de la pièce'             as label,
    'select'                       as type,
    3                              AS width,
    'Choisir un statut dans la liste...'    as  empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='quality_level';

 SELECT 
    'room_accessibility'            as name,
    'Accessibilité'                 as label,
    'select'                       as type,
    3                              AS width,
    'Choisir un statut dans la liste...'    as  empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='building_accessibility';

 SELECT 
    'room_quality_level'            as name,
    'Accessibilité'                 as label,
    'select'                       as type,
    3                              AS width,
    'Choisir un statut dans la liste...'    as  empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='quality_level';

SELECT
    'room_capacity_seats' as name,
    'number' as type,  
    'Nombre max' as label,
    'assis' as suffix,
    3 as width;

SELECT
    'room_capacity_standup' as name,
    'number' as type,  
    'Nombre max' as label,
    'debout' as suffix,
    3 as width;

SELECT
    'room_width' as name,
    'number' as type,  
    'largeur en mm' as label,
    4 as width;

SELECT
    'room_length' as name,
    'number' as type,  
    'longueur en mm' as label,
    4 as width;

SELECT
    'room_height' as name,
    'number' as type,  
    'largeur' as label,
    4 as width;

SELECT
    'room_wall_material' as name,
    'text' as type,  
    'nature des murs' as label,
    6 as width;

SELECT
    'room_wall_material' as name,
    'text' as type,  
    'nature du sol' as label,
    6 as width;
