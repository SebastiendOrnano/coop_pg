SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;


set project_id = SELECT project_id FROM project_forum_topics WHERE project_forum_topic_id=$project_forum_topic_id::INTEGER;


SELECT 
    'alert'                    as component,
    'Supprimer une discussion' as title,
    'analyze'                  as icon,
    'teal'                     as color,
    TRUE                       as dismissible,
    'La suppression est irréversible et elle entraîne la suppression de tous les project_forum_messages liés au sujet initial. Il est préférable d''archivedr la discussion' as description;

SELECT 
    '/e_project_forum/project_forum_main_delete_0.sql?project_forum_topic_id='||$project_forum_topic_id      as link,
    'alert-circle'       as icon,
    'Je confirme la suppression' as title,
    'red'    as color;

SELECT 
    '/e_project_forum/project_forum_main_close_0.sql?project_forum_topic_id='||$project_forum_topic_id      as link,
    'J''archive la discussion' as title,
    'alert-circle'       as icon,
    'green'    as color;

SELECT 
    '/e_project_forum/project_forum_main_display_4.sql?project_id='||$project_id       as link,
    'Annulation'                         as title,
    'alert-circle'                       as icon,
    'yellow'                             as color;


  