SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_5.sql') AS properties;

  set topic_id=$topic_id;

SELECT 
    'alert'                    AS component,
    'Supprimer une discussion' AS title,
    'analyze'                  AS icon,
    'teal'                     AS color,
    TRUE                       AS dismissible,
    'La suppression est irréversible et elle entraîne la suppression de tous les forum_messages liés au sujet initial. Il est préférable d''archivedr la discussion' AS description;

SELECT 
    '/c_forum/forum_main_delete_0.sql?topic_id='||$topic_id      AS link,
    'alert-circle'       AS icon,
    'Je confirme la suppression' AS title,
    'red'    AS color;

SELECT 
    '/c_forum/forum_main_archive_0.sql?topic_id='||$topic_id      AS link,
    'J''archive la discussion' AS title,
    'alert-circle'       AS icon,
    'green'    AS color;

SELECT 
    '/c_forum/forum_main_display_5.sql'       AS link,
    'Annulation'                         AS title,
    'alert-circle'                       AS icon,
    'yellow'                             AS color;


  