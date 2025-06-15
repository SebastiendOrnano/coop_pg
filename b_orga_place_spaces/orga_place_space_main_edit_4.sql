SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;


SET place_id = SELECT place_id FROM place_spaces WHERE space_id = $space_id::INTEGER;

SELECT 
    'breadcrumb' as component;
SELECT 
    'Home' as title,
    '/'    as link;
SELECT 
    'Gestion Superviseur'         as title,
    '/a_panels/panel_supervisor_4.sql' as link;

SELECT 
    'Gestion du lieu de rattachement'            as title,
    '/b_orga_place_spaces/orga_place_space_main_display_4.sql?place_id='||$place_id     as link;

SELECT 
    'form' as component,
    'Actualiser les données d''une salle' as title,
    'Mettre à jour' as validate,
    'Clear' as reset,
    '/b_orga_place_spaces/orga_place_space_main_update_0.sql?space_id='||$space_id as action;

SELECT 
    'place_id' as name,
    'hidden' as type,
    $place_id as value,
    'place_id' as label;

SELECT
    'space_id' as name,
    'hidden' as type,  
    'space_id' as label,
    $space_id as value;

SELECT
    'orga_id' as name,
    'hidden' as type,  
    'Id' as label,
    $orga_id as value;

SELECT
    'space_name' as name,
    'text' as type,  
    'Nom' as label,
    6 AS width,
    TRUE as required,
    (SELECT space_name  FROM place_spaces WHERE space_id = $space_id::INTEGER ) as value;

 SELECT 
    'space_rank'            as name,
    'Nature de la salle'                 as label,
    'select'                       as type,
    3                              AS width,
    (SELECT space_rank  FROM place_spaces WHERE space_id = $space_id::INTEGER ) as value,
    'Choisir la nature de la salle dans la liste...'    as  empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='space_rank';

 SELECT 
    'space_status'            as name,
    'Statut'                 as label,
    'select'                 as type,
    3 as width,
    TRUE                     as required,
    (SELECT space_status  FROM place_spaces WHERE space_id = $space_id::INTEGER ) as value,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='status';

SELECT
    'space_summary' as name,
    'textarea' as type,  
    'Description' as label,
    (SELECT space_summary  FROM place_spaces WHERE space_id = $space_id::INTEGER ) as value;

SELECT 
    'space_access' as name,
    'Accès à la salle' as label,
    'text' as type, 
    'indications sur l''accès à la salle : 2e étage, couloir de gauche...' AS placeholder, 
    (SELECT space_access  FROM place_spaces WHERE space_id = $space_id::INTEGER ) as value;

SELECT 
    'space_type'            as name,
    'Type de lieu'                 as label,
    'select'                       as type,
    3                              AS width,
    (SELECT space_type  FROM place_spaces WHERE space_id = $space_id::INTEGER ) as value,
    'Choisir un type dans la liste...'    as  empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='space_type';

 SELECT 
    'space_accessibility'            as name,
    'Accessibilité'                 as label,
    'select'                       as type,
    3                              AS width,
    (SELECT space_accessibility  FROM place_spaces WHERE space_id = $space_id::INTEGER ) as value,
    'Choisir un type dans la liste...'    as  empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='building_accessibility';

SELECT
    'space_capacity_seats' as name,
    'number' as type,  
    'Nombre max' as label,
    (SELECT space_capacity_seats  FROM place_spaces WHERE space_id = $space_id::INTEGER ) as value,
    'assis' as suffix,
    3 as width;

SELECT
    'space_capacity_standup' as name,
    'number' as type,  
    'Nombre max' as label,
    (SELECT space_capacity_standup  FROM place_spaces WHERE space_id = $space_id::INTEGER ) as value,
    'debout' as suffix,
    3 as width;