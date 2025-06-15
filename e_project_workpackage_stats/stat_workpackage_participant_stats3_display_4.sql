SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SET project_id = SELECT project_id FROM project_workpackage WHERE workpackage_id=$workpackage_id::INTEGER;
SET workpackage_name= SELECT workpackage_name FROM project_workpackage WHERE workpackage_id=$workpackage_id::INTEGER;
SET project_name= SELECT project_name FROM project WHERE project_id=$project_id::INTEGER;
SET worksequence_nb_participants = SELECT  worksequence_nb_participants FROM project_worksequence WHERE worksequence_id =$worksequence_id::INTEGER  and worksequence_status='active';

SELECT 
    'breadcrumb' as component;
SELECT 
    'Home' as title,
    '/'    as link;
SELECT 
    'Gestion Superviseur'         as title,
    '/a_panels/panel_supervisor_4.sql' as link;
 SELECT 
    'Hub du projet'            as title,
    '/e_project/project_hub_display_4.sql?project_id='||$project_id      as link;
 SELECT 
    'Hub du lot de travaux'            as title,
    '/e_project_workpackage/workpackage_hub_display_4.sql?workpackage_id='||$workpackage_id    as link; 

SELECT 
    'datagrid'              as component,
    'panel_workpackage_display' as id,
    'Téléchargement des temps de travail du lot de travaux' as title;
SELECT 
    '/e_project_workpackage_stats/stat_workpackage_workhours_csv_0.sql?workpackage_id='||$workpackage_id     as link,  
    'télécharger le total des heures du lot de travaux par séquence'                 as description,
    'download'                                          as icon,
    'blue'                                                as color;
SELECT 
    '/e_project_workpackage_stats/stat_workpackage_workhours_participant0_csv_0.sql?workpackage_id='||$workpackage_id     as link,  
    'télécharger le total des heures du lot de travaux par participants'                 as description,
    'download'                                          as icon,
    'red'                                                as color;

SELECT
    '/e_project_workpackage_stats/stat_workpackage_participant_stats1_form1_4.sql?workpackage_id='||$workpackage_id   as link,
    'Télécharger les données par participant'                      as description,
    'download'                                     as icon,
    'green'                                         as color;
SELECT
    '/e_project_workpackage_stats/stat_workpackage_participant_stats1_form2_4.sql?workpackage_id='||$workpackage_id  as link,
    'Télécharger les données par entrerprise'                      as description,
    'download'                                     as icon,
    'yellow'                                         as color;
SELECT
    '/e_project_workpackage_stats/stat_workpackage_participant_stats1_form3_step1_4.sql?workpackage_id='||$workpackage_id  as link,
    'Télécharger les données pour un employé d''une entreprise'                      as description,
    'download'                                     as icon,
    'red'                                         as color;
SELECT
    '/e_project_workpackage_stats/stat_workpackage_participant_stats1_form4_4.sql?workpackage_id='||$workpackage_id  as link,
    'Télécharger les données pour un groupe'                      as description,
    'download'                                     as icon,
    'green'                                         as color;