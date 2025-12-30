SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion Superviseur'         AS title,
    '/a_panels/panel_supervisor_4.sql' AS link;
 SELECT 
    'Retour à la liste des projets'            AS title,
    '/e_project/project_main_display_4.sql'     AS link;
 SELECT 
    'Retour au hub du projet'            AS title,
    '/e_project/project_hub_display_4.sql?project_id='||$project_id     AS link; 
SELECT 
    'liste des lots de travaux'    AS title,
    '/e_project_workpackage/workpackage_hub_display_4.sql?project_id='||$project_id AS link;
SELECT 
    'gestion des séquences'    AS title,
    '/e_project_worksequence/worksequence_main_display_4.sql?workpackage_id='||$workpackage_id AS link;

SELECT 
    'divider' AS component,
    'Nom du lot de travaux'    AS contents,
    'blue' AS color;
SELECT 
    'form'   AS component,
    '' AS validate;
SELECT
    'workpackage_id' AS name,
    TRUE AS readonly,
    'Id ' AS label,
    1 AS width,
   $workpackage_id AS value;
SELECT
    'workpackage_name' AS name,
    TRUE AS readonly,
    'Nom du lot de travaux' AS label,
    11 AS width,
    (SELECT workpackage_name  FROM project_workpackage WHERE workpackage_id = $workpackage_id::INTEGER ) AS value;

SELECT 
    'chart'             AS component,
    'bar'               AS type,
    'green'             AS color,
    'Avancement des séquences du lot de travaux' AS title,
    TRUE                AS horizontal,
    TRUE                AS labels;
SELECT 
    worksequence_name AS label,
    worksequence_completion_percentage   AS value
FROM project_worksequence WHERE workpackage_id=$workpackage_id::INTEGER;






