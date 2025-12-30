SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SET username = (
    SELECT users.username FROM users
    INNER JOIN sessions ON users.user_id = sessions.user_id
    WHERE sessions.session_token = sqlpage.cookie('session_token')
); 



SELECT 
    'datagrid'                                      AS component,
    'GESTION DES PROJETS'                           AS title,
    'project_supervisor_panel'                      AS id,
    'datagrid_panel'                                AS class,
    'Vous êtes loggé comme :  '||$username          AS description_md;

SELECT 
    'project'                                   AS title,
    '/e_project/project_main_display_4.sql'       AS link,
    'Gestion des projets'         AS description,
    'chart-dots-2'                                         AS icon,
    'yellow'                                        AS color;


SELECT 
    'PERSONS'                            AS title,
    '/d_prm1/prm1_main_display_4.sql'           AS link,
    'Création, suivi des personnes physiques' AS description,
    'user-plus'                                      AS icon,
     'green'                                         AS color;

SELECT 
    'COMPAGNIES'                     AS title,
    '/d_prm2/prm2_main_display_4.sql'               AS link,
    'Création, suivi des organisations'             AS description,
    'affiliate'                                     AS icon,
    'red'                                           AS color;

SELECT 
    'TEAMS'                     AS title,
    '/d_prm3/prm3_main_display_4.sql'               AS link,
    'Création, suivi des groupes'                   AS description,
    'users-group'                                   AS icon,
    'blue'                                          AS color;

SELECT           
    'WORKSPACES'                                 AS title,
    '/c_workspaces/workspace_main_display_4.sql'  AS link,
    'Groupes de travail'                          AS description,
    'users-group'                                 AS icon,
    'green'                                        AS color;


SELECT 
    'datagrid'                                       AS component,
    'GESTION DU SITE INTERNET'                       AS title,
    'supervisor_panel'                               AS id,
    'datagrid_panel'                                 AS class,
    'Vous êtes loggé comme :  '||$username           AS description_md;

SELECT 
    'ORGANIZATIONS'                                AS title,
    '/b_orga/orga_main_display_4.sql'               AS link,
    'Création, suivi des organisations'             AS description,
    'affiliate'                                     AS icon,
    'red'                                           AS color;

SELECT 
    'EVENTS'                                        AS title,
    '/b_events/event_main_display_4.sql'            AS link,
    'Évenements publics et réunions'                AS description,
    'confetti'                                      AS icon,
    'blue'                                          AS color;

SELECT 
    'NEWS'                                     AS title,
    '/b_news/news_main_display_4.sql'          AS link,
    'Gestion des actualités'                   AS description,
    'text-scan-2'                              AS icon,
    'green'                                    AS color;

SELECT 
    'FAQ'                                           AS title,
    'Questions - Réponses'                          AS description,
    'help-octagon'                                  AS icon,
    'blue'                                          AS color,
    '/b_faq/faq_main_display_4.sql'                 AS link;

SELECT 
    'PLACES'                                        AS title,
    '/b_orga_places/orga_place_main_display_4.sql'  AS link,
    'Gestion des lieux'                             AS description,
    'map-pin'                                       AS icon,
    'red'                                           AS color;

SELECT 
    '/a_rss/rss_main_display_4.sql'     AS link,
    'red'                              AS color,
    'RSS'                               AS title,
    'Liste des liens RSS à copier'      AS description,
    'rss'                               AS icon;

SELECT 
    '/a_process/process_supervisor_display_4.sql'  AS link,
    'blue'                                      AS color,
    'PROCESS'                                  AS title,
    'Processus'                                AS description,
    'automation'                               AS icon;
