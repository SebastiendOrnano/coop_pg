SET user_role = (
    SELECT user_role FROM users
    INNER JOIN sessions ON users.user_id = sessions.user_id
    WHERE sessions.session_token = sqlpage.cookie('session_token')
); 

SET redirect_link =
CASE WHEN $user_role = 'supervisor' 
THEN '/e_project_forum/project_forum_main_display_4.sql?project_id='||$project_id
ELSE '/e_project_forum/project_forum_main_display_3.sql?project_id='||$project_id
END;

SET project_forum_topic_author_id = (
    SELECT users.user_id FROM users
    INNER JOIN sessions ON users.user_id = sessions.user_id
    WHERE sessions.session_token = sqlpage.cookie('session_token')
);

-- Insert new topic
INSERT INTO project_forum_topics
(
project_id,
project_forum_topic_author_id,
project_forum_topic_name, 
project_forum_topic_category,
project_forum_topic_status,
forum_type
)
VALUES
(
$project_id::INTEGER,
$project_forum_topic_author_id::INTEGER,
:project_forum_topic_name, 
:project_forum_topic_category,
'active',
'forum'
);

-- Get the last inserted topic ID

SET project_forum_topic_id = (SELECT MAX(project_forum_topic_id) FROM project_forum_topics WHERE project_forum_topic_name = :project_forum_topic_name);

-- Insert initial message if topic ID is valid

 SET project_forum_message_author_id = (
    SELECT users.user_id FROM users
    INNER JOIN sessions ON users.user_id = sessions.user_id
    WHERE sessions.session_token = sqlpage.cookie('session_token')
); 

INSERT INTO project_forum_messages
(
project_forum_topic_id, 
project_forum_message_author_id,
project_forum_message_content,
project_forum_message_status,
project_forum_message_rank
)
VALUES
(
 $project_forum_topic_id::INTEGER,
$project_forum_message_author_id::INTEGER, 
:project_forum_message_content,
'active',
'main'
);

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
:project_doc_title,
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
$project_forum_message_id::INTEGER,
$project_id::INTEGER,
:project_doc_title_link,
:project_doc_cloud_url::TEXT,
'cloud',
'active'
WHERE COALESCE(NULLIF(TRIM(:project_doc_cloud_url::TEXT), ''), '') != '';

UPDATE project_forum_topics
SET
number_messages = number_messages +1,
updated_at = CURRENT_TIMESTAMP
WHERE project_forum_topic_id=$project_forum_topic_id::INTEGER

RETURNING 
'redirect' AS component, 
$redirect_link AS link;