SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SELECT 
    'alert'                    AS component,
    'Supprimer un espace de travail' AS title,
    'analyze'                  AS icon,
    'teal'                     AS color,
    TRUE                       AS dismissible,
    'La suppression est irréversible et entrainera la suppression de tous éléments liés : documents, réunions... !  
Il est préférable de passer le statut de l''espace de travail à "archivé"' AS description_md;

SELECT 
    '/c_workspaces/workspace_main_delete_0.sql?workspace_id='||$workspace_id      AS link,
    'alert-circle'       AS icon,
    'Je confirme la suppression' AS title,
    'red'    AS color;

SELECT 
    '/c_workspaces/workspace_main_close_0.sql?workspace_id='||$workspace_id     AS link,
    'Je ne supprime pas l''espace de travail mais j''archive l''espace de travail' AS title,
    'alert-circle'       AS icon,
    'green'    AS color;

SELECT 
    '/c_workspaces/workspace_main_display_4.sql'     AS link,
    'annulation'                         AS title,
    'alert-circle'                        AS icon,
    'red'                             AS color;
