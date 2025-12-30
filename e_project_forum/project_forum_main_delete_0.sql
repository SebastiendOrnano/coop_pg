SET project_id= SELECT project_id FROM project_forum_topics where project_forum_topic_id=$project_forum_topic_id::INTEGER;



DELETE FROM project_forum_messages 
WHERE project_forum_topic_id = $project_forum_topic_id::INTEGER;

DELETE FROM project_forum_topics 
WHERE project_forum_topic_id = $project_forum_topic_id::INTEGER

RETURNING
   'redirect' AS component,
   '/e_project_forum/project_forum_main_display_4.sql?project_id='||$project_id  as link;