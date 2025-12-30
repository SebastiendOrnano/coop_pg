SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;


SET project_id = SELECT project_id FROM project WHERE project_id=$project_id::INTEGER;
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
    'divider' AS component,
    'Nom du projet'    AS contents,
    'blue' AS color;

SELECT 
    'form'   AS component,
    '' AS validate;

SELECT
    'project_id' AS name,
    TRUE AS readonly,
    'Id ' AS label,
    1 AS width,
   $project_id AS value;

SELECT
    'project_name' AS name,
    TRUE AS readonly,
    'Nom du projet de rattachement' AS label,
    11 AS width,
    (SELECT project_name  FROM project WHERE project_id = $project_id::INTEGER ) as value;
 
SELECT 
    'divider' AS component,
    'lots de travaux archivés'    AS contents,
    'blue' AS color;

SELECT 
    'table'               AS component, 
    'Liste des lots de travaux rattachées au projet' AS title, 
    TRUE                  AS sort, 
    '/e_project_worksequence/worksequence_main_edit_4.sql?worksequence_id={id}' as edit_url,
    '/e_project_worksequence/worksequence_main_delete_alert_4.sql?worksequence_id={id}' as delete_url,
    FALSE                 AS search;

SELECT
    workpackage_id            AS Id,
    worksequence_id                     AS _sqlpage_id,
    workpackage_name            AS Nom,
    workpackage_type             AS Type
FROM project_workpackage
WHERE project_id = $project_id::INTEGER and workpackage_status='archived'
ORDER BY workpackage_id ASC;



