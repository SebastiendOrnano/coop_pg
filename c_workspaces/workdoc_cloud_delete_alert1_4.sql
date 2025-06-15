SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SELECT 
    'alert'                    AS component,
    'Supprimer un document du groupe de travail' AS title,
    'analyze'                  AS icon,
    'teal'                     AS color,
    'La suppression est irréversible!' AS description;
SELECT 
    '/c_workspaces/workdoc_cloud_delete_0.sql?workdoc_cloud_id='||$workdoc_cloud_id     AS link,
    'alert-circle'                AS icon,
    'Je confirme la suppression'  AS title,
    'red'                         AS color;
SELECT 
    '/c_workspaces/workdoc_cloud_display_4.sql?workspace_id='||$workspace_id   AS link,
    'annulation'                         AS title,
    'alert-circle'                        AS icon,
    'yellow'                             AS color;
