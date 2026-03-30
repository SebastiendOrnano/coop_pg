SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_3.sql') AS properties;


SET project_id = SELECT project_id FROM project_geo_group WHERE geo_group_id=$geo_group_id::INTEGER;

SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion éditeur'         AS title,
    '/a_panels/panel_editor.sql' AS link;
 SELECT 
    'Projets'            AS title,
    '/e_project/project_main_display_3.sql'     AS link;   
 SELECT 
    'Hub du projet'            AS title,
    '/e_project/project_hub_display_3.sql?project_id='||$project_id     AS link; 
 SELECT 
    'Topo'            AS title,
    '/e_project/geo_group_display_3.sql?project_id='||$project_id     AS link; 
SELECT 
    'Gestion des éléments topo'            AS title,
    '/e_project_geo/geo_main_display_3.sql?geo_group_id='||$geo_group_id    AS link;

SELECT 
    'form' AS component,
    'Créer une parcelle' AS title,
    'Créer' AS validate,
    'Clear' AS reset,
    '/e_project_geo/geo_geojson_single_create_0.sql?geo_group_id='||$geo_group_id AS action;

SELECT
    'geo_title' AS name,
    'text' AS type,  
    'Nom de l''élément' AS label,
    6 AS width,
    TRUE AS required;

 SELECT 
    'geo_category'          AS name,
    'Catégorie'              AS label,
    'select'                 AS type,
    TRUE                     AS required,
    6                        AS width,
    (SELECT geo_status  FROM project_geo WHERE geo_id=$geo_id::INTEGER ) AS value,
    'Choisir un statut dans la liste...'    AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='geo_category';


SELECT 
    'geo_data_input'        AS name,
    'file'                            AS type,
    'application/geo+json'            AS accept,
    'Fichier geojson simple'          AS label,
    'Upload coordo of a land plot'    AS description,
    12                                  AS width,
    TRUE                              AS required;
