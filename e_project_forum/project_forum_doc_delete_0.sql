
SET project_forum_message_id = SELECT project_forum_message_id FROM project_docs WHERE project_doc_id = $project_doc_id::INTEGER;
SET project_forum_topic_id = SELECT  project_forum_topic_id FROM project_forum_messages WHERE project_forum_message_id=$project_forum_message_id::INTEGER;

SET redirect_link = '/e_project_forum/project_forum_message_display_4.sql?project_forum_topic_id='||$project_forum_topic_id;


DELETE FROM project_docs
WHERE project_doc_id = $project_doc_id::INTEGER

RETURNING 
'redirect' AS component, 
$redirect_link AS link;