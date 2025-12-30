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
    'Gestion des lieux actifs'            as title,
    '/b_orga_places/orga_place_main_display_4.sql'     as link;


SELECT 
    'divider' as component,
    'Nom du lieu de rattachement'    as contents,
    'blue' as color;

SELECT 
    'form'   as component,
    '' as validate;

SELECT
    'place_id' as name,
    TRUE as readonly,
    'Id ' as label,
    1 as width,
   $place_id as value;

SELECT
    'place_name' as name,
    TRUE as readonly,
    'Nom du lieu de rattachement' as label,
    11 as width,
    (SELECT place_name  FROM place WHERE place_id = $place_id::INTEGER) as value;

SELECT 
    'table'               AS component, 
    'Liste des salles rattachées au lieu' AS title, 
    TRUE                  AS sort, 
    JSON('{"name":"Pict","tooltip":"Photos de la salle","link":"/b_orga_place_spaces/orga_place_space_picture_display_4.sql?space_id={id}","icon":"photo-scan"}') as custom_actions,
    '/b_orga_place_spaces/orga_place_space_main_edit_4.sql?space_id={id}' as edit_url,
    '/b_orga_place_spaces/orga_place_space_main_delete_alert_4.sql?space_id={id}' as delete_url,
    FALSE                 AS search;

SELECT
    space_id            AS Id,
    space_id            as _sqlpage_id,
    space_name            AS Nom,
    space_rank            AS Niveau,
    space_capacity_seats      AS Assis,
    space_capacity_standup as Debout
FROM place_spaces
WHERE place_id = $place_id::INTEGER AND space_status!='active'
ORDER BY space_id ASC;


