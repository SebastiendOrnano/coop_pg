SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SELECT 
    'alert'                    AS component,
    'Supprimer un document du groupe de travail' AS title,
    'analyze'                  AS icon,
    'teal'                     AS color,
    'La suppression est irréversible!' AS description;
SELECT 
    '/e_project_docs/project_doc_delete_0.sql?project_doc_id='||$project_doc_id||'&project_id='||$project_id      AS link,
    'alert-circle'                AS icon,
    'Je confirme la suppression'  AS title,
    'red'                         AS color;
SELECT 
    '/e_project_docs/project_doc_display_4.sql?project_id='||$project_id   AS link,
    'annulation'                         AS title,
    'alert-circle'                        AS icon,
    'yellow'                             AS color;
