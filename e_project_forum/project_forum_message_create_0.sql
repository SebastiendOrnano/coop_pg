-- Insert reply message if topic ID is valid

SET author = (
    SELECT users.username FROM users
    INNER JOIN sessions ON users.user_id = sessions.user_id::INTEGER
    WHERE sessions.session_token = sqlpage.cookie('session_token')
); 

SET user_role = (
    SELECT user_role FROM users
    INNER JOIN sessions ON users.user_id = sessions.user_id::INTEGER
    WHERE sessions.session_token = sqlpage.cookie('session_token')
); 

set project_id = SELECT project_id FROM project_forum_topics WHERE project_forum_topic_id=$project_forum_topic_id::INTEGER;



SET redirect_link =
CASE WHEN $user_role = 'supervisor' 
THEN '/e_project_forum/project_forum_message_display_4.sql?project_forum_topic_id='||$project_forum_topic_id
ELSE '/e_project_forum/project_forum_message_display_3.sql?project_forum_topic_id='||$project_forum_topic_id
END;

SET project_forum_message_author_id = (
    SELECT users.user_id FROM users
    INNER JOIN sessions ON users.user_id = sessions.user_id::INTEGER
    WHERE sessions.session_token = sqlpage.cookie('session_token')
); 


INSERT INTO project_forum_messages 
(
project_forum_topic_id, 
project_forum_message_author_id,
project_forum_message_content,
project_forum_message_status
)
SELECT 
$project_forum_topic_id::INTEGER, 
$project_forum_message_author_id::INTEGER, 
:project_forum_message_content,
'active'
WHERE :project_forum_message_content IS NOT NULL;

SET project_forum_message_id = (SELECT MAX(project_forum_message_id) FROM project_forum_messages WHERE project_forum_topic_id = $project_forum_topic_id::INTEGER);

INSERT INTO project_docs
(
project_forum_message_id,
project_id,
project_doc_title,
project_doc_url,
project_doc_local_cloud,
project_doc_status
)
SELECT
$project_forum_message_id::INTEGER,
$project_id::INTEGER,
COALESCE(NULLIF(TRIM(:project_doc_title), ''), 'no title'),
CASE WHEN sqlpage.persist_uploaded_file('project_doc_url', 'x_project_docs', 'doc,docx,odt,md,pdf,jpg,jpeg,png')IS NOT NULL OR sqlpage.persist_uploaded_file('workdoc_url', 'x_workspace_docs', 'doc,docx,odt,md,pdf,jpg,jpeg,png') !='' 
THEN sqlpage.persist_uploaded_file('project_doc_url', 'x_project_docs', 'doc,docx,odt,md,pdf,jpg,jpeg,png')
ELSE '' END,
'local',
'active'
WHERE sqlpage.persist_uploaded_file('project_doc_url', 'x_project_docs', 'doc,docx,odt,md,pdf,jpg,jpeg,png')IS NOT NULL OR sqlpage.persist_uploaded_file('workdoc_url', 'x_workspace_docs', 'doc,docx,odt,md,pdf,jpg,jpeg,png') !='';

INSERT INTO project_docs
(
    project_forum_message_id,
    project_id,
    project_doc_title_link,
    project_doc_cloud_url,
    project_doc_local_cloud,
    project_doc_status
)
SELECT
    :project_forum_message_id::INTEGER,
    :project_id::INTEGER,
    COALESCE(NULLIF(TRIM(:project_doc_title_link), ''), 'no title'),
    :project_doc_cloud_url::TEXT,
    'cloud',
    'active'
WHERE :project_doc_cloud_url::TEXT IS NOT NULL 
  AND TRIM(:project_doc_cloud_url::TEXT) != '';

UPDATE project_forum_topics
SET
number_messages = number_messages +1,
updated_at = CURRENT_TIMESTAMP
WHERE project_forum_topic_id=$project_forum_topic_id::INTEGER

RETURNING 
'redirect' AS component, 
$redirect_link AS link;