SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

set prm1_doc_id=$prm1_doc_id;

SELECT 
    'alert'                    AS component,
    'Supprimer un document l''prm1nisation' AS title,
    'analyze'                  AS icon,
    'teal'                     AS color,
    TRUE                       AS dismissible,
    'La suppression est irréversible!' AS description;
SELECT 
    '/d_prm1_doc/prm1_doc_main_delete_0.sql?prm1_doc_id='||$prm1_doc_id      AS link,
    'alert-circle'       AS icon,
    'Je confirme la suppression' AS title,
    'red'    AS color;

SELECT 
    '/d_prm1_doc/prm1_doc_main_display_4.sql'    AS link,
    'annulation'                         AS title,
    'alert-circle'                        AS icon,
    'yellow'                             AS color;
