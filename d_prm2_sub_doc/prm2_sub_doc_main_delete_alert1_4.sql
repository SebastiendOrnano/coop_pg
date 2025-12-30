SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SET prm2_sub_id = SELECT prm2_sub_id FROM prm2_sub_docs WHERE prm2_sub_doc_id =$prm2_sub_doc_id::INTEGER;

SELECT 
    'alert'                    AS component,
    'Supprimer un document l''organisation' AS title,
    'analyze'                  AS icon,
    'teal'                     AS color,
    TRUE                       AS dismissible,
    'La suppression est irréversible!' AS description;
SELECT 
    '/d_prm2_sub_doc/prm2_sub_doc_main_delete_0.sql?prm2_sub_doc_id='||$prm2_sub_doc_id||'&prm2_sub_id='||$prm2_sub_id     AS link,
    'alert-circle'       AS icon,
    'Je confirme la suppression' AS title,
    'red'    AS color;

SELECT 
    '/d_prm2_sub_doc/prm2_sub_doc_main_display_4.sql?prm2_sub_id='||$prm2_sub_id    AS link,
    'annulation'                         AS title,
    'alert-circle'                        AS icon,
    'yellow'                             AS color;
