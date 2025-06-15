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
    'PROJECTS'                                   AS title,
    '/e_project/project_main_display_3.sql'       AS link,
    'Gestion des projets'         AS description,
    'chart-dots-2'                                         AS icon,
    'yellow'                                        AS color;


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





