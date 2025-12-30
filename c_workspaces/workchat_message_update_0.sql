-- Insert reply message if topic ID is valid

SET user_role = (
    SELECT user_role FROM users
    INNER JOIN sessions ON users.user_id = sessions.user_id
    WHERE sessions.session_token = sqlpage.cookie('session_token')
); 

SET topic_id = SELECT topic_id FROM forum_messages WHERE message_id = $message_id::INTEGER;

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

UPDATE forum_messages 
SET
message_content = :message_content
WHERE message_id  = $message_id::INTEGER;

UPDATE  workdocs
SET
workdoc_url = 
CASE 
WHEN sqlpage.persist_uploaded_file('workdoc_url', 'x_workspace_docs', 'doc,docx,odt,md,pdf,jpg,jpeg,png')IS NOT NULL OR sqlpage.persist_uploaded_file('workdoc_url', 'x_workspace_docs', 'doc,docx,odt,md,pdf,jpg,jpeg,png') !='' 
THEN sqlpage.persist_uploaded_file('workdoc_url', 'x_workspace_docs', 'doc,docx,odt,md,pdf,jpg,jpeg,png')
ELSE workdoc_url END
WHERE message_id  = $message_id::INTEGER;

UPDATE workdocs_cloud
SET
workdoc_cloud_url = :workdoc_cloud_url
WHERE message_id  = $message_id::INTEGER

RETURNING 
'redirect' AS component, 
$redirect_link AS link;