SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SET project_id = SELECT project_id FROM project_geo_group WHERE geo_group_id=$geo_group_id::INTEGER;

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
    'Actualiser un groupe' AS title,
    'Actualiser' AS validate,
    'Clear' AS reset,
    '/e_project_geo/geo_group_update_0.sql?geo_group_id='||$geo_group_id AS action;

SELECT
    'geo_group_title' AS name,
    'text' AS type,  
    'Nom du groupe' AS label,
    6 AS width,
    (SELECT geo_group_title FROM project_geo_group WHERE geo_group_id=$geo_group_id::INTEGER) as value,
    TRUE AS required;
SELECT 
    'geo_group_rank'         AS name,
    'Niveau du groupe'       AS label,
    'select'                 AS type,
    TRUE                     AS required,
    3                        AS width,
     (SELECT geo_group_rank FROM project_geo_group WHERE geo_group_id=$geo_group_id::INTEGER) as value,
    'Choisir un statut dans la liste...'    AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='geo_group_level';
SELECT 
    'geo_group_status'         AS name,
    'Niveau du groupe'       AS label,
    'select'                 AS type,
    TRUE                     AS required,
    3                        AS width,
     (SELECT geo_group_status FROM project_geo_group WHERE geo_group_id=$geo_group_id::INTEGER) as value,
    'Choisir un statut dans la liste...'    AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',i.choice_label, 'value', i.choice_value))  AS options
    FROM choices_items AS i
    LEFT JOIN (SELECT choice_category_id, choice_category_name FROM choices_categories)  AS c 
    ON i.choice_category_id = c.choice_category_id
    WHERE choice_category_name='status';
SELECT
    'geo_group_description' AS name,
    'textarea' AS type, 
     (SELECT geo_group_description FROM project_geo_group WHERE geo_group_id=$geo_group_id::INTEGER) as value,
    'Présentation du group' AS label;
