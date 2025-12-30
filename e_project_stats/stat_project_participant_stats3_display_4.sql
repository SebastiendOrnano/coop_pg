SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SET project_name = SELECT project_name FROM project WHERE project_id=$project_id::INTEGER;

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
    'panel_workpackage_display' AS id,
    'Téléchargement des temps de travail par sequence' AS title;
SELECT 
    '/e_project_stats/stat_project_workhours_workpackage_csv_0.sql?project_id='||$project_id       AS link,
    'télécharger le total des heures par lot de travaux'                 AS description,
    'download'                                          AS icon,
    'orange'                                                AS color;
SELECT 
    '/e_project_stats/stat_project_workhours_sequence_csv_0.sql?project_id='||$project_id       AS link,
    'télécharger le total des heures par sequence'                 AS description,
    'download'                                          AS icon,
    'blue'                                                AS color;
SELECT 
    '/e_project_stats/stat_project_workhours_participants_csv_0.sql?project_id='||$project_id        AS link,
    'télécharger le total des heures pour tous les participants'                 AS description,
    'download'                                          AS icon,
    'red'                                                AS color;