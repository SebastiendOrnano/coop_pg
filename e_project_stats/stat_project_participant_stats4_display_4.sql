SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SET project_name = SELECT project_name FROM project WHERE project_id=$project_id::INTEGER;

SELECT 
    'breadcrumb' as component;
SELECT 
    'Home' as title,
    '/'    as link;
SELECT 
    'Gestion Superviseur'         as title,
    '/a_panels/panel_supervisor_4.sql' as link;
 SELECT 
    'Retour à la liste des projets'            as title,
    '/e_project/project_main_display_4.sql'     as link;
 SELECT 
    'Retour au hub du projet'            as title,
    '/e_project/project_hub_display_4.sql?project_id='||$project_id     as link; 

SELECT 
    'datagrid'              as component,
    'panel_workpackage_display' as id,
    'Téléchagement des temps de travail par participant' as title;
SELECT
    '/e_project_stats/stat_project_participant_select_form1_4.sql?project_id='||$project_id   as link,
    'Télécharger les données par participant'                      as description,
    'download'                                     as icon,
    'green'                                         as color;
SELECT
    '/e_project_stats/stat_project_participant_select_form2_4.sql?project_id='||$project_id   as link,
    'Télécharger les données par entrerprise'                      as description,
    'download'                                     as icon,
    'yellow'                                         as color;
SELECT
    '/e_project_stats/stat_project_participant_select_form3_step1_4.sql?project_id='||$project_id   as link,
    'Télécharger les données pour un employé d''une entreprise'                      as description,
    'download'                                     as icon,
    'red'                                         as color;
SELECT
    '/e_project_stats/stat_project_participant_select_form4_4.sql?project_id='||$project_id   as link,
    'Télécharger les données pour un groupe'                      as description,
    'download'                                     as icon,
    'green'                                         as color;
