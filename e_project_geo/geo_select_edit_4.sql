SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SELECT 
    'alert'                     AS component,
    TRUE AS important,
    'Les modifications dans le formulaire seront appliquées à tous les documents sélectionnées !' AS description,
    'alert-triangle'            AS icon,
      TRUE                       AS dismissible,
    'yellow'                    AS color;

SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion superviseur'               AS title,
    '/a_panels/panel_supervisor_4.sql' AS link;
 SELECT 
    'Projets'                                   AS title,
    '/e_project/project_main_display_4.sql'     AS link;   
 SELECT 
    'Hub du projet'                                                     AS title,
    '/e_project/project_hub_display_4.sql?project_id='||$project_id     AS link; 
SELECT 
    'Gestion des parcelles'                                                AS title,
    '/e_project_geo/geo_main_display_4.sql?project_id='||$project_id     AS link;


SELECT 
    'form' AS component,
    'Actualiser la description desparcelles sélectionnées' AS title,
    'Mettre à jour' AS validate,
    'Clear' AS reset,
    '/e_project_geo/geo_select_update_0.sql?project_id='||$project_id  AS action;

SELECT 
    'geo_status'        AS name,
    'Statut'                 AS label,
    'select'                 AS type,
    3                        AS width,
    'Choisir un statut dans la liste...'    AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='status';

SELECT
    'geo_code_postal' AS name,
    'text' AS type,  
    'Code postal' AS label,
    2                        AS width;


SELECT
    'geo_code_insee' AS name,
    'text' AS type,  
    'Code Insee' AS label,
    2                        AS width;

SELECT 
   'building_id' AS name,
   'Bâtiment en lien avec la parcelle' AS label,
   'select' AS type,
   5 AS width,
   'Sélectionner un bâtiment...' AS empty_option,
   json_agg(
     json_build_object(
       'label', m.building_name,
       'value', m.building_id
     )
   ) AS options
FROM (
  SELECT DISTINCT m.building_id, m.building_name, m.project_id
  FROM project_building AS m
  JOIN project_geo AS p
    ON m.project_id = p.project_id
  WHERE p.project_id = $project_id::INTEGER
) AS m;




