SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_3.sql') AS properties;

SET username = (
    SELECT users.username FROM users
    INNER JOIN sessions ON users.user_id = sessions.user_id
    WHERE sessions.session_token = sqlpage.cookie('session_token')
); 


SELECT 
    'datagrid'                                      AS component,
    'Panneau d''administration éditeur projets'         AS title,
    'project_supervisor_panel'                               AS id,
    'datagrid_panel'                                AS class,
    'Vous êtes loggé comme :  '||$username      AS description_md;

SELECT 
    'GROUPES DE TRAVAIL'                          AS title,
    '/c_workspaces/workspace_main_display_3.sql'       AS link,
    'Groupes de travail'                          AS description,
    'users-group'                                 AS icon,
    'blue'                                        AS color;

SELECT 
    'PERSONS'                            AS title,
    '/d_prm1/prm1_main_display_3.sql'           AS link,
    'Création, suivi des personnes physiques' AS description,
    'user-plus'                                      AS icon,
     'green'                                         AS color;

SELECT 
    'COMPAGNIES'                     AS title,
    '/d_prm2/prm2_main_display_3.sql'               AS link,
    'Création, suivi des organisations'             AS description,
    'affiliate'                                     AS icon,
    'red'                                           AS color;

SELECT 
    'GROUPS'                     AS title,
    '/d_prm3/prm3_main_display_3.sql'               AS link,
    'Création, suivi des groupes'                   AS description,
    'users-group'                                   AS icon,
    'blue'                                          AS color;

SELECT 
    'project'                                   AS title,
    '/e_project/project_main_display_3.sql'       AS link,
    'Gestion des projets'         AS description,
    'chart-dots-2'                                         AS icon,
    'yellow'                                        AS color;


SELECT 
    'datagrid'                                  AS component,
    'Activités au sein de la communauté'         AS title,
    'supervisor_editor'                         AS id,
    'datagrid_panel'                            AS class,
    'Vous êtes loggé comme :  '||$username      AS description_md;


SELECT 
    'EVENTS'                    AS title,
    '/b_events/event_main_display_3.sql'      AS link,
    'Gestion des évenements'                      AS description,
    'list-details'                                AS icon,
    'green'                                       AS color;

SELECT 
    'NEWS'                                      AS title,
    '/b_news/news_main_display_3.sql'            AS link,
    'News'                                       AS description,
    'text-scan-2'                                AS icon,
    'orange'                                      AS color;

SELECT 
    '/a_rss/rss_main_display_3.sql'     AS link,
    'red'                               AS color,
    'RSS'                               AS title,
    'Liens RSS à copier'                AS description,
    'rss'                               AS icon;

SELECT 
    '/a_process/process_editor_display_3.sql'  AS link,
    'lue'                                      AS color,
    'PROCESS'                                  AS title,
    'Processus'                                AS description,
    'automation'                               AS icon;



