SET user_role = (
    SELECT user_role FROM users
    INNER JOIN sessions ON users.user_id = sessions.user_id
    WHERE sessions.session_token = sqlpage.cookie('session_token')
); 

SET redirect_link =
CASE WHEN $user_role = 'supervisor' 
THEN '/e_project_docs/project_doc_select_display_4.sql?project_id='||$project_id
ELSE '/e_project_docs/project_doc_select_display_3.sql?project_id='||$project_id
END;


UPDATE project_docs
SET     
    project_doc_author = COALESCE(NULLIF(:project_doc_author, ''), project_doc_author), 
    project_doc_keywords = COALESCE(NULLIF(:project_doc_keywords, ''), project_doc_keywords),
    project_doc_date_publication =
    CASE
       WHEN :project_doc_date_publication IS NULL THEN project_doc_date_publication
       WHEN :project_doc_date_publication ~ '^\d{1,4}-\d{2}-\d{2}$' THEN :project_doc_date_publication::DATE
      ELSE NULL END,
    project_doc_date_period =
    CASE
       WHEN :project_doc_date_period IS NULL THEN project_doc_date_period
       WHEN :project_doc_date_period ~ '^\d+$' THEN :project_doc_date_period::INTEGER
      ELSE NULL END,
    project_doc_format = COALESCE(NULLIF(:project_doc_format, ''), project_doc_format),
    project_doc_lang = COALESCE(NULLIF(:project_doc_lang, ''), project_doc_lang),
    project_doc_category = COALESCE(NULLIF(:project_doc_category, ''), project_doc_category),
    project_doc_type =  COALESCE(NULLIF(:project_doc_type, ''), project_doc_type),
    project_doc_status = COALESCE(NULLIF(:project_doc_status, ''), project_doc_status),
    updated_at = CURRENT_TIMESTAMP
WHERE project_doc_selected = true;

UPDATE project_docs
SET 
    project_doc_selected= false,
    updated_at = CURRENT_TIMESTAMP

RETURNING 
'redirect' AS component, 
$redirect_link AS link;