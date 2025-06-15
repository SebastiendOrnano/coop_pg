SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion superviseur'         AS title,
    '/a_panels/panel_supervisor_4.sql' AS link;
 SELECT 
    'Projets'            AS title,
    '/e_project/project_main_display_4.sql'     AS link; 
SELECT 
    'Hub projet'            AS title,
    '/e_project/project_hub_display_4.sql?project_id='||$project_id     AS link;

SELECT 
    'form' AS component,
    'Choisir le workpackage parent' AS title,
    'Créer' AS validate,
    'Clear' AS reset,
    '/e_project_workpackage/workpackage_main_form3_4.sql?project_id='||$project_id AS action;

SELECT 
   'workpackage_id' AS name,
    'Choisir le workpackage parent' AS label,
    'select' AS type,
    8 AS width,
    TRUE AS searchable,
    'Choississez dans la liste' AS empty_option,
    json_agg(JSON_BUILD_OBJECT('label',workpackage_name, 'value', workpackage_id)) AS options
    FROM (
    SELECT workpackage_name, workpackage_id
    FROM project_workpackage WHERE project_id=$project_id::INTEGER
    ORDER BY workpackage_id ASC
    );
