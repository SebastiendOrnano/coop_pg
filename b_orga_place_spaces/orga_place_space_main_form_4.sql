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
    'gestion des événements'            as title,
    '/b_events/event_main_display_4.sql'     as link;


SELECT 
    'form' as component,
    'Créer une salle' as title,
    'Créer' as validate,
    'Clear' as reset,
    '/b_orga_place_spaces/orga_place_space_main_create_0.sql?place_id='||$place_id as action;

SELECT 
    'space_id' as name,
    'hidden' as type,
    $space_id as value,
    'id' as label;

SELECT
    'space_name' as name,
    'text' as type,  
    'Nom' as label,
    6 AS width,
    TRUE as required;

 SELECT 
    'space_rank'            as name,
    'Nature de la salle'                 as label,
    'select'                       as type,
    3                              AS width,
    'Choisir la nature de la salle dans la liste...'    as  empty_option,
    'Choisir la nature de la salle dans la liste...'    as  empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name="space_rank";

SELECT 
    'space_status'            as name,
    'Statut'                 as label,
    'select'                 as type,
    3                              AS width,
    TRUE                     as required,
    'Choisir un statut dans la liste...'    as empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='status';

SELECT
    'space_summary' as name,
    'textarea' as type,
    'Disposition, équipement, lumière...' as description,
    'Présentation de la salle' as label;

SELECT 
    'space_access' as name,
    'Accès à la salle' as label,
    'text' as type, 
    'Accès à la salle : bâtiment, escalier, couloir, ascenceur...' AS description;

 SELECT 
    'space_type'            as name,
    'Type de salle'                 as label,
    'select'                       as type,
    3                              AS width,
    'Choisir un type dans la liste...'    as  empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name="space_type";


 SELECT 
    'space_accessibility'            as name,
    'Accessibilité'                 as label,
    'select'                       as type,
    3                              AS width,
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
    'assis' as suffix,
    3 as width;

SELECT
    'space_capacity_standup' as name,
    'number' as type,  
    'Nombre max' as label,
    'debout' as suffix,
    3 as width;
