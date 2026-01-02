SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_3.sql') AS properties;

SET workpackage_name = SELECT workpackage_name FROM project_workpackage WHERE workpackage_id = $workpackage_id::INTEGER ;
set project_id = SELECT project_id FROM project_workpackage WHERE workpackage_id=$workpackage_id::INTEGER;

SELECT 
    'breadcrumb' AS component;
SELECT 
    'Home' AS title,
    '/'    AS link;
SELECT 
    'Gestion éditeur'         AS title,
    '/a_panels/panel_editor_3.sql' AS link;
SELECT 
    'Projets'            AS title,
    '/e_project/project_main_display_3.sql'   AS link;   
 SELECT 
    'Hub projet'            AS title,
    '/e_project/project_hub_display_3.sql?project_id='||$project_id     AS link;   
SELECT 
    'Hub lot de travaux'            AS title,
    '/e_project_workpackage/workpackage_hub_display_3.sql?workpackage_id='||$workpackage_id    AS link;

SELECT 
    'datagrid'              AS component,
    'datagrid_panel' AS id,
    'Gestion du lot de travaux : '||$workpackage_name AS title;
SELECT 
    '/e_project_worksequence/worksequence_main_form_3.sql?workpackage_id='||$workpackage_id       AS link,
    'Création d''un nouveau séquence'                  AS description,
    'subtask'                                      AS icon,
    'yellow'                                         AS color;

SELECT 
   '/e_project_workpackage_participants/workpackage_participant_main_display_3.sql?workpackage_id='||$workpackage_id            AS link,
    'WKP Participants'                  AS description,
    'users'                                            AS icon,
    'blue'                                              AS color;
SELECT 
   '/e_project_workpackage_expenses/expense_main_display_3.sql?workpackage_id='||$workpackage_id            AS link,
    'Dépenses - achats'                  AS description,
    'tax-euro'                                            AS icon,
    'red'                                              AS color;
SELECT 
   '/e_project_workpackage_materials/material_main_display_3.sql?workpackage_id='||$workpackage_id            AS link,
    'Bilan carbone matériaux'                                       AS description,
    'alarm-smoke'                                                       AS icon,
    'yellow'                                                        AS color;
SELECT 
   '/e_project_workpackage_waste/waste_main_display_3.sql?workpackage_id='||$workpackage_id            AS link,
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
    '/e_project_worksequence/worksequence_main_edit_3.sql?worksequence_id={id}' as edit_url,
    FALSE                 AS search;

SELECT
    worksequence_id                     AS Id,
    worksequence_id                     AS _sqlpage_id,
    worksequence_name                   AS Nom,
    worksequence_start_date_scheduled   AS Date,
    worksequence_start_hour_scheduled    AS Heure
FROM project_worksequence
WHERE workpackage_id =$workpackage_id::INTEGER and worksequence_status != 'archived'
ORDER BY worksequence_id ASC;
