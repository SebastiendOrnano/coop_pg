SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_5.sql') AS properties;

SET process_id=$process_id;

SELECT 
    'alert'                        as component,
    'Suppression d''un processus'  as title,
    'alert-triangle'               as icon,
    'red'                          as color,
    'Cette suppression entrainera la suppression de toutes les étapes liées à ce processus ! Par prudence, il vaut mieux choisir le statut ''archivé''' as description;

SELECT 
    '/a_process/process_main_display_5.sql'                 as link,
    'Revenir à la liste des processus'                      as title,
    'green'                                                 as color;

SELECT 
    '/a_process/process_main_delete_0.sql?process_id='||$process_id   as link,
    'Suppression'                                                     as title,
    'red'                                                             as color; 



