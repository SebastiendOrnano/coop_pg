SELECT 'dynamic' AS component, sqlpage.run_sql('a_shells/shell_4.sql') AS properties;

SELECT 
    'breadcrumb' as component;
SELECT 
    'Home' as title,
    '/'    as link;
SELECT 
    'Gestion Admin'         as title,
    '/a_panels/panel_admin_4.sql' as link;
SELECT 
    'Liste des discussions'         as title,
    '/e_project_forum/project_forum_main_display_4.sql?project_id='||$project_id as link;


-- Get the last inserted topic ID
SET project_forum_topic_id = (SELECT MAX(project_forum_topic_id) FROM project_forum_topics WHERE project_forum_topic_name = :project_forum_topic_name);

-- Display list of project_forum_topics
SELECT 'table' AS component, 
    'Forum project_forum_topics'   AS title, 
    'View'                 AS markdown, 
    TRUE                   AS sort, 
    TRUE                   AS search;

SELECT       -- NOTE: the dots join values FROM the project_forum_topics and project_forum_messages tables
   --  t.forum_group                AS G, (if group filter is actived)
    t.project_forum_topic_id                   AS ID,
    t.project_forum_topic_name                 AS Topic,
    t.project_forum_topic_status               AS Statut,
    t.project_forum_topic_category             AS Categorie,
    m.created_at                 AS Created_at,
    t.number_messages             AS Nb,
   (SELECT username FROM users WHERE users.user_id =  project_forum_topic_author_id)   AS Contributeur,
    '[Discussion](/e_project_forum/project_forum_message_display_4.sql?project_forum_topic_id=' || t.project_forum_topic_id ||  ')&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [Edit](/e_project_forum/project_forum_main_edit_4.sql?project_forum_topic_id=' || t.project_forum_topic_id ||')&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [Delete](/e_project_forum/project_forum_main_delete_alert1_4.sql?project_forum_topic_id=' || t.project_forum_topic_id ||')&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [Disclose](/e_project_forum/project_forum_main_disclose_0.sql?project_forum_topic_id=' || t.project_forum_topic_id ||')'    AS View
FROM project_forum_topics AS t
LEFT JOIN (
    SELECT project_forum_topic_id, MAX(created_at) AS created_at FROM project_forum_messages
    GROUP BY project_forum_topic_id) AS m 
    ON t.project_forum_topic_id = m.project_forum_topic_id
WHERE  t.project_forum_topic_status ='archived' AND t.forum_type='forum'
ORDER BY t.project_forum_topic_status DESC, m.created_at DESC;