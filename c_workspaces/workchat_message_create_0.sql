-- Insert reply message if topic ID is valid

SET user_role = (
    SELECT user_role FROM users
    INNER JOIN sessions ON users.user_id = sessions.user_id
    WHERE sessions.session_token = sqlpage.cookie('session_token')
); 

SET redirect_link =
CASE 
WHEN $user_role = 'supervisor' 
THEN '/c_workspaces/workchat_message_display_4.sql?topic_id='||$topic_id
ELSE '/c_workspaces/workchat_message_display_3.sql?topic_id='||$topic_id
END;

SET message_author_id = (
    SELECT users.user_id FROM users
    INNER JOIN sessions ON users.user_id = sessions.user_id
    WHERE sessions.session_token = sqlpage.cookie('session_token')
); 

INSERT INTO forum_messages 
(
topic_id, 
message_author_id,
message_content,
message_status
)
SELECT 
$topic_id::INTEGER, 
$message_author_id::INTEGER, 
:message_content,
'active'
WHERE :message_content IS NOT NULL;

SET message_id = (SELECT MAX(message_id) FROM forum_messages WHERE topic_id = $topic_id::INTEGER);

SET workspace_id = select workspace_id FROM forum_topics where topic_id=$topic_id::INTEGER;

INSERT INTO workdocs
(
message_id,
workspace_id,
workdoc_url,
workdoc_status
)
SELECT
$message_id::INTEGER,
$workspace_id::INTEGER,
CASE 
WHEN sqlpage.persist_uploaded_file('workdoc_url', 'x_workspace_docs', 'doc,docx,odt,md,pdf,jpg,jpeg,png')IS NOT NULL OR sqlpage.persist_uploaded_file('workdoc_url', 'x_workspace_docs', 'doc,docx,odt,md,pdf,jpg,jpeg,png') !='' 
THEN sqlpage.persist_uploaded_file('workdoc_url', 'x_workspace_docs', 'doc,docx,odt,md,pdf,jpg,jpeg,png')
ELSE '' END,
'active'
WHERE WHEN sqlpage.persist_uploaded_file('workdoc_url', 'x_workspace_docs', 'doc,docx,odt,md,pdf,jpg,jpeg,png')IS NOT NULL OR sqlpage.persist_uploaded_file('workdoc_url', 'x_workspace_docs', 'doc,docx,odt,md,pdf,jpg,jpeg,png') !='' ;

INSERT INTO workdocs_cloud
(
message_id,
workspace_id,
workdoc_cloud_url,
workdoc_cloud_status
)
SELECT
$message_id::INTEGER,
$workspace_id::INTEGER,
:workdoc_cloud_url::TEXT,
'active'
WHERE COALESCE(NULLIF(TRIM(:workdoc_cloud_url::TEXT), ''), '') <> '';


UPDATE forum_topics
SET
number_messages = number_messages +1,
updated_at = CURRENT_TIMESTAMP
WHERE topic_id=$topic_id::INTEGER

RETURNING 
'redirect' AS component, 
$redirect_link AS link;