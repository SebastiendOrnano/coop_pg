-- Récupération des informations de base
set project_forum_topic_id = SELECT project_forum_topic_id FROM project_forum_messages WHERE project_forum_message_id=$project_forum_message_id::INTEGER;
set project_id = SELECT project_id FROM project_forum_topics WHERE project_forum_topic_id=$project_forum_topic_id::INTEGER;

-- Vérification des droits utilisateur
SET user_role = 
(
    SELECT user_role FROM users
    INNER JOIN sessions ON users.user_id = sessions.user_id
    WHERE sessions.session_token = sqlpage.cookie('session_token')
);

-- Détermination du lien de redirection
SET redirect_link =
CASE WHEN $user_role = 'supervisor' 
THEN '/e_project_forum/project_forum_message_display_4.sql?project_forum_topic_id='||$project_forum_topic_id
ELSE '/e_project_forum/project_forum_message_display_3.sql?project_forum_topic_id='||$project_forum_topic_id
END;

-- Mise à jour du message du forum
UPDATE project_forum_messages 
SET
project_forum_message_content = :project_forum_message_content,
project_forum_message_status = :project_forum_message_status,
updated_at = CURRENT_TIMESTAMP
WHERE project_forum_message_id = $project_forum_message_id::INTEGER;

SET project_doc_id_local = SELECT project_doc_id FROM project_docs WHERE  project_doc_local_cloud='local' AND   project_forum_message_id=$project_forum_message_id::INTEGER;

UPDATE project_docs 
SET
    project_doc_title = COALESCE(NULLIF(TRIM(:project_doc_title), ''), 'no title'),
    project_doc_cloud_url = :project_doc_cloud_url::TEXT,
    project_doc_url = 
    CASE 
    WHEN sqlpage.persist_uploaded_file('project_doc_url', 'x_project_docs', 'doc,docx,odt,md,pdf,jpg,jpeg,png')IS NOT NULL OR sqlpage.persist_uploaded_file('workdoc_url', 'x_workspace_docs', 'doc,docx,odt,md,pdf,jpg,jpeg,png') !='' 
    THEN sqlpage.persist_uploaded_file('project_doc_url', 'x_project_docs', 'doc,docx,odt,md,pdf,jpg,jpeg,png')
    ELSE '' 
    END,
    project_doc_status = 'active',
    updated_at = CURRENT_TIMESTAMP
    WHERE project_doc_id=$project_doc_id_local::INTEGER AND sqlpage.persist_uploaded_file('project_doc_url', 'x_project_docs', 'doc,docx,odt,md,pdf,jpg,jpeg,png')IS NOT NULL OR sqlpage.persist_uploaded_file('workdoc_url', 'x_workspace_docs', 'doc,docx,odt,md,pdf,jpg,jpeg,png') !='';

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
    :project_id::INTEGER,
    COALESCE(NULLIF(TRIM(:project_doc_title), ''), 'no title'),
    :project_doc_url::TEXT,
    'local',
    'active'
WHERE $project_doc_id_local IS NULL;


SET project_doc_id_cloud = SELECT project_doc_id FROM project_docs WHERE  project_doc_local_cloud='cloud' AND   project_forum_message_id=$project_forum_message_id::INTEGER;

UPDATE project_docs 
SET
    project_doc_title_link = COALESCE(NULLIF(TRIM(:project_doc_title_link), ''), 'no title'),
    project_doc_cloud_url = :project_doc_cloud_url::TEXT,
    project_doc_status = 'active',
    updated_at = CURRENT_TIMESTAMP
    WHERE project_doc_id=$project_doc_id_cloud::INTEGER;

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
WHERE $project_doc_id_cloud IS NULL

   
-- Redirection
SELECT 
    'redirect' AS component, 
    $redirect_link AS link;