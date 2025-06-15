SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_5.sql') AS properties;

SET username = (
    SELECT users.username FROM users
    INNER JOIN sessions ON users.user_id = sessions.user_id
    WHERE sessions.session_token = sqlpage.cookie('session_token')
); 

SELECT 
    'datagrid'                                        AS component,
    'Panneau d''administration admin'           AS title,
    'Vous êtes loggé comme :  '||$username            AS description_md;

SELECT 
    'INFO SITE'                                    AS title,
    'Infos administratives... sur le site'          AS description,
    'help-octagon'                                  AS icon,
    'green'                                         AS color,
    '/a_info/section_main_display_5.sql'            AS link;

SELECT 
    '/a_users/user_new_display_5.sql'       AS link,
    'red'                                   AS color,
    'NEW USERS'                             AS title,
    'Gestion des comptes en attente'        AS description,
    'user-exclamation'                      AS icon;

SELECT 
    '/a_users/user_main_display_5.sql'      AS link,
    'green'                                 AS color,
    'USERS'                                 AS title,
    'Gestion des utilisateurs'              AS description,
    'user-exclamation'                      AS icon;

SELECT 
    '/c_forum/forum_main_display_5.sql'      AS link,
    'blue'                                   AS color,
    'FORUM'                                  AS title,
    'Modération du forum'                    AS description,
    'arrows-random'                          AS icon;

SELECT 
    '/c_debug/debug_main_display_5.sql'      AS link,
    'blue'                                   AS color,
    'BUG REPORT'                             AS title,
    'Bug report'                             AS description,
    'bug'                                    AS icon;

SELECT 
    '/a_process/process_main_display_5.sql'    AS link,
    'orange'                                   AS color,
    'PROCESS'                                  AS title,
    'Gestion des processus'                    AS description,
    'automation'                               AS icon;

SELECT 
    '/a_rss/rss_main_display_5.sql'     AS link,
    'blue'                              AS color,
    'RSS'                               AS title,
    'Liste des liens RSS à copier'      AS description,
    'rss'                               AS icon;

SELECT 
    '/a_info/section_help_display_5.sql'     AS link,
    'green'                                  AS color,
    'DOC COOP'                               AS title,
    'Gestion Help Dev'                       AS description,
    'help-circle'                            AS icon;

SELECT 
    '/a_info/help_dev_FR_5.sql'     AS link,
    'yellow'                        AS color,
    'HELP FR'                       AS title,
    'Aide pour les dev'             AS description,
    'help'                          AS icon;

SELECT 
    '/a_info/help_dev_EN_5.sql'    AS link,
    'red'                          AS color,
    'HELP EN'                      AS title,
    'Help for dev'                 AS description,
    'help'                         AS icon;

SELECT 
    '/a_sessions/session_stats_5.sql'    AS link,
    'green'                                AS color,
    'STAT SESSIONS'                     AS title,
    'Statistiques connexions'           AS description,
    'database-x'                         AS icon;

SELECT 
    '/a_sessions/session_purge_alert_5.sql'    AS link,
    'red'                                      AS color,
    'PURGE SESSIONS'                           AS title,
    'Purge sessions table'                     AS description,
    'database-x'                               AS icon;

SELECT 
    'blue'                           AS color,
    'SqlPage version'                AS title,
    sqlpage.version()                AS description,
    'device-ipad-question'           AS icon;

SELECT 
    '/a_choices/choice_main_display_5.sql'    AS link,
    'red'                                     AS color,
    'CHOICES'                                 AS title,
    'Listes of choices'                       AS description,
    'list-check'                              AS icon;

SELECT 
    '/a_choices/regex_main_display_5.sql'    AS link,
    'red'                                     AS color,
    'REGEX'                                 AS title,
    'Regex pattern'                        AS description,
    'brackets-contain'                     AS icon;




