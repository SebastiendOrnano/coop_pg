SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SET place_id = SELECT place_id FROM place_spaces WHERE space_id = $space_id::INTEGER;


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

set space_name=(SELECT space_name  FROM place_spaces WHERE space_id = $space_id::INTEGER);

SELECT 
    'datagrid' as component;
SELECT 
    '/b_orga_place_spaces/orga_place_space_picture_form_4.sql?space_id='||$space_id     as link,
    'Nouvelle image / plan'  as description,
    'photo-scan'  as icon;


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
   $space_id as value;

SELECT
    'place_name' as name,
    TRUE as readonly,
    'Nom du lieu de rattachement' as label,
    11 as width,
    (SELECT space_name  FROM place_spaces WHERE space_id = $space_id::INTEGER ) as value;
 
SELECT 
    'divider' as component,
    'images rattachées au lieu'    as contents,
    'blue' as color;

SELECT 
    'table'               AS component, 
    'Liste des images rattachées au lieu' AS title, 
    TRUE                  AS sort,
    'Img'                  AS markdown, 
    JSON('{"name":"Pict","tooltip":"Photos de la salle","link":"/b_orga_place_spaces/orga_place_space_picture_view_4.sql?space_picture_id={id}","icon":"photo-scan"}') as custom_actions,
    '/b_orga_place_spaces/orga_place_space_picture_edit_4.sql?space_picture_id={id}' as edit_url,
    '/b_orga_place_spaces/orga_place_space_picture_delete_alert_4.sql?space_picture_id=={id}' as delete_url,
    FALSE                 AS search;

SELECT
    '[![view picture]('||space_picture_url||')]('||space_picture_url||')' AS Img,
    space_picture_id            AS Id,
    space_picture_id            as _sqlpage_id,
    space_picture_title            AS Nom,
    space_picture_format            AS Format
FROM place_spaces_pictures
WHERE space_id = $space_id::INTEGER
ORDER BY space_picture_id ASC;






