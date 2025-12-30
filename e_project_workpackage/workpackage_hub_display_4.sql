SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SET workpackage_name = SELECT workpackage_name FROM project_workpackage WHERE workpackage_id = $workpackage_id::INTEGER ;
set project_id = SELECT project_id FROM project_workpackage WHERE workpackage_id=$workpackage_id::INTEGER;

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
    'datagrid'              AS component,
    'datagrid_panel' AS id,
    'Tableau de bord du lot de travaux : '||$workpackage_name AS title;
SELECT 
    '/e_project_workpackage_stats/stat_workpackage_timeline_display_4.sql?workpackage_id='||$workpackage_id      AS link,
    'Planning des séquences chantiers'                  AS description,
    'treadmill'                                      AS icon,
    'yellow'                                         AS color;
SELECT
    '/e_project_workpackage_stats/stat_workpackage_carbon_footprint_display_4.sql?workpackage_id='||$workpackage_id   AS link,
    'Bilan carbone du lot de travaux'                      AS description,
    'alarm-smoke'                                     AS icon,
    'green'                                           AS color;
SELECT
    '/e_project_workpackage_stats/stat_workpackage_cost_display_4.sql?workpackage_id='||$workpackage_id  AS link,
    'Coûts des travaux par lot de travaux'                      AS description,
    'currency-euro'                                     AS icon,
    'blue'                                           AS color;
SELECT 
    '/e_project_workpackage_stats/stat_workpackage_waste_display_4.sql?workpackage_id='||$workpackage_id          AS link,
    'Gestion des déchets'                      AS description,
    'archive'                                     AS icon,
    'yellow'                                       AS color;

SELECT
    '/e_project_workpackage_stats/stat_workpackage_participant_stats1_display_4.sql?workpackage_id='||$workpackage_id   AS link,
    'Heures de travail cumulées par séquence'                      AS description,
    'clock-24'                                     AS icon,
    'red'                                           AS color;
SELECT
    '/e_project_workpackage_stats/stat_workpackage_participant_stats2_display_4.sql?workpackage_id='||$workpackage_id  AS link,
    'Heures de travail cumulées par type de participant'                      AS description,
    'clock-24'                                     AS icon,
    'blue'                                         AS color;
SELECT
    '/e_project_workpackage_stats/stat_workpackage_participant_stats3_display_4.sql?workpackage_id='||$workpackage_id   AS link,
    'Télécharger  toutes les données'                      AS description,
    'download'                                     AS icon,
    'yellow'                                         AS color;


SELECT 
    'datagrid'              AS component,
    'datagrid_panel' AS id,
    'Gestion du lot de travaux : '||$workpackage_name AS title;
SELECT 
    '/e_project_worksequence/worksequence_main_form_4.sql?workpackage_id='||$workpackage_id       AS link,
    'Création d''un nouveau séquence'                  AS description,
    'subtask'                                      AS icon,
    'yellow'                                         AS color;

SELECT 
    '/e_project_worksequence/worksequence_archive_display_4.sql?workpackage_id='||$workpackage_id             AS link,
    'Visualiser les séquences archivées'           AS description,
    'archive'                                     AS icon,
    'green'                                              AS color;
    
SELECT 
   '/e_project_workpackage_participants/workpackage_participant_main_display_4.sql?workpackage_id='||$workpackage_id            AS link,
    'WKP -  Participants'                  AS description,
    'users'                                            AS icon,
    'blue'                                              AS color;
SELECT 
   '/e_project_workpackage_expenses/expense_main_display_4.sql?workpackage_id='||$workpackage_id            AS link,
    'Dépenses - achats'                  AS description,
    'tax-euro'                                            AS icon,
    'red'                                              AS color;
SELECT 
   '/e_project_workpackage_materials/material_main_display_4.sql?workpackage_id='||$workpackage_id            AS link,
    'Bilan carbone matériaux'                                       AS description,
    'alarm-smoke'                                                       AS icon,
    'yellow'                                                        AS color;
SELECT 
   '/e_project_workpackage_waste/waste_main_display_4.sql?workpackage_id='||$workpackage_id            AS link,
    'Gestion des déchets'                  AS description,
    'trash'                                            AS icon,
    'blue'                                              AS color;

SELECT 
    'divider' AS component,
    'séquences rattachées au lot de travaux'    AS contents,
    'blue' AS color;

SELECT 
    'table'               AS component, 
    'Liste des séquences rattachées au lot de travaux' AS title, 
    TRUE                  AS sort, 
    JSON('{"name":"WKS - Participants","tooltip":"Intervenants sur le lot de travail","link":"/e_project_worksequence_participants/worksequence_participant_main_display_4.sql?worksequence_id={id}","icon":"users"}') as custom_actions,
    '/e_project_worksequence/worksequence_main_edit_4.sql?worksequence_id={id}' as edit_url,
    '/e_project_worksequence/worksequence_main_delete_alert_4.sql?worksequence_id={id}' as delete_url,
    FALSE                 AS search;

SELECT
    worksequence_id                     AS Id,
    worksequence_id                     AS _sqlpage_id,
    worksequence_name                   AS Nom,
    worksequence_start_date_scheduled   AS Date,
    to_char(worksequence_start_hour_scheduled, 'HH24:MI')    AS Heure
FROM project_worksequence
WHERE workpackage_id =$workpackage_id::INTEGER and worksequence_status != 'archived'
ORDER BY worksequence_id ASC;