SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SELECT 
    'alert'                    AS component,
    'Suppression d''projet!' AS title,
    'analyze'                  AS icon,
    'teal'                     AS color,
    TRUE                       AS dismissible,
    'Cette suppression entrainera la suppression de tous les éléments liés ! Par prudence, il vaut mieux choisir le statut ''archivé''' AS description;

SELECT 
    '/e_project/project_main_delete_0.sql?project_id='||$project_id        AS link,
    'Suppression'                                         AS title,
    'alert-circle'                                        AS icon,
    'red'                                                 AS color;

SELECT 
    '/e_project/project_main_archive_0.sql?project_id='||$project_id       AS link,
    'changer le statut'                                AS title,
    'alert-circle'                                     AS icon,
    'green'                                            AS color; 

SELECT 
    '/e_project/project_main_display_4.sql'    AS link,
    'Retour à la liste'             AS title,
    'arrow_left'                  AS icon,
    'orange'                     AS color;



