SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;


SET project_id = SELECT project_id FROM project_workpackage WHERE workpackage_id=$workpackage_id::INTEGER;

SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion Superviseur'         AS title,
    '/a_panels/panel_supervisor_4.sql' AS link;
SELECT 
    'Hub project'            AS title,
    '/e_project/project_hub_display_4.sql?project_id='||$project_id     AS link;
SELECT 
    'Lots de travaux - sequences actives'            AS title,
    '/e_project_workpackage/workpackage_hub_display_4.sql?workpackage_id='||$workpackage_id    AS link;   

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
    'Id' AS label,
    1 AS width,
    (SELECT workpackage_id  FROM project_workpackage WHERE workpackage_id = $workpackage_id::INTEGER ) AS value;
SELECT
    'workpackage_name' AS name,
    TRUE AS readonly,
    'Nom du lot de travaux' AS label,
    5 AS width,
    (SELECT workpackage_name  FROM project_workpackage WHERE workpackage_id = $workpackage_id::INTEGER ) AS value;
SELECT
    'workpackage_type' AS name,
    TRUE AS readonly,
    'Type de travaux' AS label,
    6 AS width,
    (SELECT workpackage_type FROM project_workpackage WHERE workpackage_id = $workpackage_id::INTEGER ) AS value;
 
SELECT 
    'divider' AS component,
    'séquences rattachées au lot de travaux'    AS contents,
    'blue' AS color;

SELECT 
    'table'               AS component, 
    'Liste des séquences rattachées au lot de travaux' AS title, 
    TRUE                  AS sort, 
    'View'                AS markdown, 
    FALSE                 AS search;

SELECT
    worksequence_id            AS Id,
    worksequence_name            AS Nom,
'[Participants](/e_project_worksequence_participants/worksequence_participant_main_display_4.sql?worksequence_id='||worksequence_id|| 
') &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [Edit](/e_project_worksequence/worksequence_main_edit_4.sql?worksequence_id='||worksequence_id|| 
') &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [Delete](/e_project_worksequence/worksequence_main_delete_alert_4.sql?worksequence_id='||worksequence_id||
')'    AS View
FROM project_worksequence
WHERE workpackage_id =$workpackage_id::INTEGER and worksequence_status='archived'
ORDER BY worksequence_id ASC;


