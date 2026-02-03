SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SET project_id = SELECT project_id FROM project_geo WHERE geo_id=$geo_id::NTEGER;

SET building_name = (SELECT building_name  FROM project_building AS b 
    LEFT JOIN (SELECT building_id, geo_id from project_geo) AS l
    on b.building_id = l.building_id
    WHERE l.geo_id=$geo_id::NTEGER );
SET building_id = SELECT building_id from project_geo where geo_id=$geo_id::INTEGER;
SET building_name = SELECT building_name from project_building WHERE building_id=$building_id::INTEGER;

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
    'form'       AS component,
    'Actualiser les coordonées géo à partir d''une série de coordonnées' AS title,
    'Entrer les coordonnées'  AS validate,
    '/e_project_geo/geo_coordo_create_0.sql?project_id='||$project_id AS action;
SELECT 
    'coordo'          AS name,
    'Coordo'          AS label,
    '[[long1,lat1],long2,lat2],[long3,lat3],[],[],[],[]]' AS description,
    'text'            AS type, 
    TRUE              AS required,
    12                AS width;


SELECT
    'form'       AS component,
    'Actualiser les coordonées géo à partir d''un fichier' AS title,
    'Chargez le nouveau fichier geojson'  AS validate,
    '/e_project_geo/geo_geojson_single_upload_0.sql?project_id='||$project_id AS action;
SELECT
    'geo_data_input'                    AS name,
    'file'                               AS type,
    'application/geo+json'               AS accept,
    'Fichiergeojson à charger'           AS label,
    'Chargez le nouveau fichier geojson' AS description,
    TRUE                                 AS required;

SELECT 
    'form' AS component,
    'Actualiser la description de la parcelle' AS title,
    'Mettre à jour' AS validate,
    'Clear' AS reset,
    '/e_project_geo/geo_main_update_0.sql?geo_id='||$geo_id  AS action;

SELECT
    'geo_title' AS name,
    'text' AS type,  
    'Nom' AS label,
    12 AS width,
    TRUE AS required,
    (SELECT geo_title  FROM project_geo WHERE geo_id=$geo_id::NTEGER ) AS value;

 SELECT 
    'geo_status'        AS name,
    'Statut'                 AS label,
    'select'                 AS type,
    TRUE                     AS required,
    3                        AS width,
    (SELECT geo_status  FROM project_geo WHERE geo_id=$geo_id::NTEGER ) AS value,
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
    2                        AS width,
    (SELECT geo_code_postal  FROM project_geo WHERE geo_id=$geo_id::NTEGER ) AS value;


SELECT
    'geo_code_insee' AS name,
    'text' AS type,  
    'Code postal' AS label,
    2                        AS width,
    (SELECT geo_code_insee  FROM project_geo WHERE geo_id=$geo_id::NTEGER ) AS value;

SELECT
    'geo_code_land_registry' AS name,
    'text' AS type,  
    'N° parcelle cadastrale' AS label,
    2                       AS width,
    (SELECT geo_code_land_registry  FROM project_geo WHERE geo_id=$geo_id::NTEGER ) AS value;

SELECT 
   'building_id' AS name,
   'Bâtiment en lien avec la parcelle' AS label,
    'select' AS type,
    5 AS width,
    (SELECT building_id from project_geo where geo_id=$geo_id::INTEGER) AS value,
    'Sélectionner un bâtiment...' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',m.building_name,'value',m.building_id)) AS options
    FROM project_building AS m
    LEFT JOIN (SELECT project_id, building_id, geo_id from project_geo) AS p
    ON m.project_id = p.project_id
    WHERE p.geo_id=$geo_id::NTEGER;


SELECT
    'geo_description' AS name,
    'textarea' AS type,  
    'Description' AS label,
    (SELECT geo_description  FROM project_geo WHERE geo_id=$geo_id::NTEGER ) AS value;


