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
    'Créer un workpackage' AS title,
    'Créer' AS validate,
    'Clear' AS reset,
    '/e_project_workpackage/workpackage_main_selector_0.sql?project_id='||$project_id AS action;
SELECT 
    'workpackage'              AS name,
    'radio'                  AS type,
    'independant'                   AS value,
    'Non lié à un autre workpackage' AS description,
    'workpackage indépendant'                   AS label;
SELECT 
    'workpackage' AS name,
    'radio'     AS type,
    'linked'       AS value,
    'Il débutera à la fin du workpackage précédent' AS description,
    'workpackage lié au workpackage précédent'       AS label;
