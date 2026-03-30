SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion superviseur'         AS title,
    '/a_panels/panel_supervisor.sql' AS link;
 SELECT 
    'Projets'            AS title,
    '/e_project/project_main_display_4.sql'     AS link;   
 SELECT 
    'Hub du projet'            AS title,
    '/e_project/project_hub_display_4.sql?project_id='||$project_id     AS link; 
SELECT 
    'Gestion des groupes topo'            AS title,
    '/e_project_geo/geo_group_display_4.sql?project_id='||$project_id     AS link; 
      
SELECT 
    'form' AS component,
    'Créer un traçé à partir de coordonnées' AS title,
    'Créer' AS validate,
    'Clear' AS reset,
    '/e_project_geo/geo_group_create_0.sql?project_id='||$project_id AS action;

SELECT
    'geo_group_title' AS name,
    'text' AS type,  
    'Nom du groupe' AS label,
    7 AS width,
    TRUE AS required;
SELECT 
    'geo_group_rank'         AS name,
    'Niveau du groupe'       AS label,
    'select'                 AS type,
    TRUE                     AS required,
    3                        AS width,
    'Choisir un statut dans la liste...'    AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='geo_group_level';
SELECT
    'geo_group_description' AS name,
    'textarea' AS type,  
    'Présentation du group' AS label;
